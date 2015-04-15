class EmailContact < ActiveRecord::Base
  scope :region_id,  ->(email_address) { where('email = ?', email_address) }
end
