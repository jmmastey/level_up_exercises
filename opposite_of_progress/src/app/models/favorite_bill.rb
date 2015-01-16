class FavoriteBill < ActiveRecord::Base
  belongs_to :bill
  belongs_to :user
end
