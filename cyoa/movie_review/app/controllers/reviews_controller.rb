class ReviewsController < ApplicationController
	before_action :authenticate_user!
	def create
		@review = Review.new(review_params)
		@review.user_id = current_user_id
	end

	private
		def review_params
			params.require(:review).permit(:rating, :comment)
		end
end
