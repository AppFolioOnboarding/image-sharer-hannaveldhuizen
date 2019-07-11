require 'test_helper'
module Api
  class FeedbacksControllerTest < ActionDispatch::IntegrationTest
    setup do
      @feedback = Feedback.new
    end

    test 'should create feedback' do
      assert_difference 'Feedback.count', 1 do
        post api_feedbacks_path, params: { feedback: { name: 'Hanna', comments: 'Comments' } }
      end

      assert_equal 200, response.status

      body = JSON.parse(response.body)
      assert_equal body['message'], 'success'

      fb = Feedback.last
      assert_equal 'Hanna', fb.name
      assert_equal 'Comments', fb.comments
    end

    test 'should not create feedback without a name' do
      assert_no_difference 'Feedback.count' do
        post api_feedbacks_path, params: { feedback: { name: '', comments: 'Comments' } }
      end

      assert_equal 422, response.status

      body = JSON.parse(response.body)
      assert_equal body['message'], 'error'
    end

    test 'should not create feedback without comments' do
      assert_no_difference 'Feedback.count' do
        post api_feedbacks_path, params: { feedback: { name: 'Hanna', comments: '' } }
      end

      assert_equal 422, response.status

      body = JSON.parse(response.body)
      assert_equal body['message'], 'error'
    end
  end
end
