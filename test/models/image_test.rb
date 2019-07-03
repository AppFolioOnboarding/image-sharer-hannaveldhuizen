require 'test_helper'

class ImageTest < ActiveSupport::TestCase
  setup do
    @image = Image.new
  end

  test 'should not create an image with an invalid url' do
    image = Image.new(url: 'hello')
    assert_no_difference('Image.count') do
      image.save
    end

    assert_includes image.errors.messages[:url], 'You must input a valid URL.'
  end

  test 'should create an image with a valid url' do
    image = Image.new(url: 'https://hello.com')
    assert_difference('Image.count', 1) do
      image.save
    end
  end

  test 'should not create an image with a blank url' do
    image = Image.new(url: '')
    assert_no_difference('Image.count') do
      image.save
    end
  end

end
