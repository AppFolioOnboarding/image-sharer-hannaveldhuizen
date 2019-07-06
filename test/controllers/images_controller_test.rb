require 'test_helper'

class ImagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @image = Image.new
  end

  test 'should get new' do
    get new_image_url
    assert_response :success
    assert_select 'h1', 'Create New Image'
    assert_select '#image_tag_list', count: 1
    assert_select '#image_url', count: 1
    assert_select '.btn', count: 1
  end

  test 'should create image' do
    assert_difference 'Image.count', 1 do
      post images_url, params: { image: { url: 'https://hello.com' } }
    end

    assert_redirected_to image_url(Image.last)
  end

  test 'should create an image with the correct tag list' do
    assert_difference 'Image.count', 1 do
      post images_url, params: { image: { url: 'https://hello.com', tag_list: 'hello, hi' } }
    end

    img = Image.last

    assert_equal %w[hello hi], img.tag_list
  end

  test 'should not create an image with an invalid url' do
    assert_no_difference 'Image.count' do
      post images_url, params: { image: { url: 'hello' } }
    end
  end

  test 'should show image' do
    @image.update(url: 'https://hello.com')
    get image_url(@image)
    assert_response :success
    assert_select 'img', count: 1
    assert_select 'h1', "ID: #{@image.id}"
  end

  test 'should list all images in reverse chronological order' do
    image1 = Image.create(url: 'https://1.com')
    image2 = Image.create(url: 'https://2.com')
    image3 = Image.create(url: 'https://3.com')
    images = [image3, image2, image1]

    get images_url

    assert_response :success
    assert_select 'img', count: 3
    assert_select 'img', count: 3 do |elements|
      elements.each.with_index do |element, i|
        assert_equal images[i][:url], element[:src]
      end
    end
  end
end
