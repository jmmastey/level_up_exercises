class Category < ActiveRecord::Base
  belongs_to :user
  before_save { self.name = name.titleize }
  validates_presence_of :name, :user_id
  validates_uniqueness_of :name, scope: :user_id, case_sensitive: false
end
