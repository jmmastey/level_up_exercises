class Feed < ActiveRecord::Base
  belongs_to :user, foreign_key: :owner_user_id
end
