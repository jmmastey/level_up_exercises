class UserChannel < ActiveRecord::Base
  belongs_to :user
  belongs_to :channel
end
