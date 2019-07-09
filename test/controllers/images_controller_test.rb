require 'test_helper'

class ImagesControllerTest < ActionDispatch::IntegrationTest # rubocop:disable Metrics/ClassLength
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

  test 'should list tags on show page' do
    @image.update(url: 'https://hello.com', tag_list: ['my special tag', 'another one'])
    get image_url(@image)

    assert_response :success
    assert_select 'a', count: 2 do |elements|
      assert_equal elements[0].text, 'my special tag'
      assert_equal elements[1].text, 'another one'
    end
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

  test 'should list tags associated with each picture on index page' do
    all_tags = ['newer image', 'tags should come first', 'older image', 'last tag']
    Image.create(url: 'https://1.com', tag_list: ['older image', 'last tag'])
    Image.create(url: 'https://2.com', tag_list: ['newer image', 'tags should come first'])

    get images_url

    assert_response :success
    assert_select 'img', count: 2
    assert_select 'a', count: 4 do |elements|
      elements.each.with_index do |element, i|
        assert_equal all_tags[i], element.text
      end
    end
  end

  test 'should list only the images associated with a certain tag' do
    Image.create(url: 'https://1.com', tag_list: ['my tag', 'hello', 'whats up'])
    Image.create(url: 'https://2.com', tag_list: ['my tag', 'another one'])
    Image.create(url: 'https://3.com', tag_list: ['another one'])

    get images_path tag: 'my tag'
    assert_response :success
    assert_select 'img', count: 2

    get images_path tag: 'another one'
    assert_response :success
    assert_select 'img', count: 2

    get images_path tag: 'wrong tag'
    assert_response :success
    assert_select 'img', count: 0
  end

  test 'should delete the right image' do
    img1 = Image.create(url: 'https://1.com')
    img2 = Image.create(url: 'https://2.com')

    assert_equal img2.id, Image.last.id
    assert_difference 'Image.count', -1 do
      delete image_url id: img2.id
    end
    assert_redirected_to images_path
    assert_equal img1.id, Image.last.id
  end

  test 'should not delete an image that does not exist' do
    assert_difference 'Image.count', 0 do
      delete image_url id: 1
    end
  end
end
