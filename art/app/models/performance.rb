class Performance < ActiveRecord::Base
  belongs_to :show

  validates :performed_on, presence: true
  validates :show, presence: true
end
