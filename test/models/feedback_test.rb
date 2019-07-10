require 'test_helper'

class FeedbackTest < ActiveSupport::TestCase
  test 'should not create feedback without a name' do
    feedback = Feedback.new(name: '', comments: 'test')

    assert_no_difference('Feedback.count') do
      feedback.save
    end

    assert_not(feedback.valid?)
    assert_equal(feedback.errors.full_messages[0], 'Name can\'t be blank')
  end

  test 'should create feedback when all params are given' do
    feedback = Feedback.new(name: 'test name', comments: 'test comments')

    assert_difference('Feedback.count', 1) do
      feedback.save
    end

    assert(feedback.valid?)
  end

  test 'should not create feedback without comments' do
    feedback = Feedback.new(name: 'test', comments: '')

    assert_no_difference('Feedback.count') do
      feedback.save
    end

    assert_not(feedback.valid?)
    assert_equal(feedback.errors.full_messages[0], 'Comments can\'t be blank')
  end
end
