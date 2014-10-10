class Category < ActiveRecord::Base
  has_many :metrics

  validates :name, presence: true,
                   uniqueness: { case_sensitive: false }

end
