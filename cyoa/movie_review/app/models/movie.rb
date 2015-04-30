class Movie < ActiveRecord::Base
	has_many :reviews
end
