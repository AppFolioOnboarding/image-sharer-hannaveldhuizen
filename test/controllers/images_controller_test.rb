require 'test_helper'

class ImagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @image = Image.new
  end

  test 'should get new' do
    get new_image_url
    assert_response :success
    assert_select 'h1', 'Create New Image'
    assert_select '#image_url', count: 1
  end

  test 'should create image' do
    assert_difference('Image.count', 1) do
      post images_url, params: { image: { url: 'https://hello.com' } }
    end

    assert_redirected_to image_url(Image.last)
  end

  test 'should not create an image with an invalid url' do
    assert_no_difference('Image.count') do
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
end
