class User < ActiveRecord::Base
  belongs_to :address
  has_many :ratings
end
