class EventDate < ActiveRecord::Base
  belongs_to :venue, dependent: :destroy
  belongs_to :event, dependent: :destroy

  # validates_each 'venue', 'event' do |param|
  validates :venue, presence: true
  validates :event, presence: true
  # end

  default_scope -> {order(date_time: :asc)}
end
