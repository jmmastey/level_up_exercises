class EventDate < ActiveRecord::Base
  belongs_to :venue, dependent: :destroy
  belongs_to :event, dependent: :destroy

  validates_each :venue, :event do |param|
    validates param, presence: true
  end
end
