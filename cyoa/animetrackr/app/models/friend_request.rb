class FriendRequest < ActiveRecord::Base
  belongs_to :from, class_name: 'User', foreign_key: 'from_id'
  belongs_to :to, class_name: 'User', foreign_key: 'to_id'

  validates :from,
            presence: true

  validates :to,
            presence: true
  validate :users_must_be_unique
  validate :no_duplicate_requests

  def self.get_pending(user)
    where(from: user)
  end

  def self.get_requests(user)
    where(to: user)
  end

  private

  def users_must_be_unique
    errors.add(:from, "can't be you") if from == to
  end

  def no_duplicate_requests
    request = FriendRequest.where(to: to, from: from)
    errors.add(:to, "request already sent and is pending") unless request.empty?
  end
end
