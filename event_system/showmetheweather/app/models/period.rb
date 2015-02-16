class Period < ActiveRecord::Base
  belongs_to :forecast
  has_many :predictions, dependent: :destroy
end
