class Artist < ActiveRecord::Base
  validates :name, presence: true,
                   uniqueness: { case_sensitive: false }
end
