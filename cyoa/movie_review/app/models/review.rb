class Review < ActiveRecord::Base
	belongs_to :user
	belongs_to :movie
	validates_numericality_of :rating, only_integer: true, allow_nil: false,
		greater_than_or_equal_to: 0,
		less_than_or_equal_to: 5,
		message: "Rating can only be number between 0 and 5."

	validates_presence_of :comment,
		message: "Comment cannot be empty."
end
