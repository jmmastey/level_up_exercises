class Deed < ActiveRecord::Base
  def self.all_related(deed)
    Deed.where('id != ? and (bioguide_id = ? or bill_id = ?)',
               deed.id, deed.bioguide_id, deed.bill_id)
  end

  def self.all_sorted(page, sort_by = "created_at DESC")
    Deed.order(sort_by).paginate(page: page, per_page: ENV["PAGINATION_COUNT"])
  end
end
