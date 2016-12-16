class BillTag < ActiveRecord::Base
  belongs_to :bill
  belongs_to :tag

  validates :bill_id, uniqueness: { scope: :tag_id, message: 'Duplicate tag' }
end
