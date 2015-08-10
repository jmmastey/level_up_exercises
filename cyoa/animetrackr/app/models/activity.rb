class Activity < ActiveRecord::Base
  belongs_to :anime
  belongs_to :user
end
