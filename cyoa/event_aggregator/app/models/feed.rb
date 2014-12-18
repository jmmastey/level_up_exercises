class Feed < ActiveRecord::Base
  belongs_to :user, foreign_key: :owner_user_id
  has_and_belongs_to_many :selection_criteria
end
