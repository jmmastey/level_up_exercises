class Review < ActiveRecord::Base
	belongs_to :user
	belongs_to :movie
	validates :rating, presence: true
	validates :comment, presence: true
end
