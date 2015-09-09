class Achievement < ActiveRecord::Base
  has_many :character_zone_activites, dependent: :destroy
end
