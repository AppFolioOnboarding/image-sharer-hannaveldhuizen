module Api
  class FeedbacksController < ApplicationController
    def create
      @feedback = Feedback.new(params.require(:feedback).permit(:name, :comments))

      if @feedback.save
        render status: :ok, json: { message: 'success' }
      else
        render status: :unprocessable_entity, json: { message: 'error' }
      end
    end
  end
end
