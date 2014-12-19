class Deed < ActiveRecord::Base
  scope :all_sorted, ->(page, sort_by) { order(sort_by).paginate(page: page) }
  scope :related_bill, ->(deed) { where(bioguide_id: deed.bioguide_id).first }

  def self.all_related(deed)
    Deed.where('id != ? and (bioguide_id = ? or bill_id = ?)',
               deed.id, deed.bioguide_id, deed.bill_id)
  end
end
