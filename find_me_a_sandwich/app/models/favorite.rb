class Favorite < ActiveRecord::Base
  belongs_to(:user)
  has_one(:menu_item)
end
