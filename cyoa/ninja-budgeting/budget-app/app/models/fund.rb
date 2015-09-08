class Fund < ActiveRecord::Base
  belongs_to :user
  before_save { self.amount = amount.round(2) }
  validates_presence_of :name, :user_id, :fund_type
  validates_uniqueness_of :name, scope: :user_id, case_sensitive: false
  validates :amount, presence: true, numericality: true
  serialize :components, Hash
end
