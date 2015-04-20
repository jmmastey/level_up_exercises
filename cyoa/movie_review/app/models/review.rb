class Review < ActiveRecord::Base
	belongs_to :user
	belongs_to :movie
	validates_presence_of :rating
	validates_presence_of :comment,
		message: "Comment cannot be empty."
end
