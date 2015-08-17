class Friend < ActiveRecord::Base
  belongs_to :user
  belongs_to :friend, class_name: 'User'

  validates :user,
            presence: true
  validates :friend,
            presence: true

  def self.get_friends(user)
    where(user: user)
  end
end
