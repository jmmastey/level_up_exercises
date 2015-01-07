class GoodDeed < ActiveRecord::Base
  validates_presence_of :action
  validates_presence_of :acted_at
  validates_presence_of :bill_id
  belongs_to :bill
  belongs_to :legislator
end
