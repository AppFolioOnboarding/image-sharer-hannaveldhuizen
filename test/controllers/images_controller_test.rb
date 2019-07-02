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
end
