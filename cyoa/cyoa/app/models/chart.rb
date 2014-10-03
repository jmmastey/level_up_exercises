class Chart < ActiveRecord::Base
  belongs_to :service

  validates :service, presence: true
  validates :scope, presence: true, inclusion: { in: %w(month day) }
end
