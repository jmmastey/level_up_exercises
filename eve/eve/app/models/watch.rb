class Watch < ActiveRecord::Base
  belongs_to :user
  belongs_to :item
  belongs_to :region
  belongs_to :station

  validates_presence_of :item, :user
  validates_with LocationFilterValidator

  def average_price
    orders.average(:price)
  end

  def orders
    filtered_orders = item.orders
    filtered_orders = filtered_orders.where(region: region) if region
    filtered_orders = filtered_orders.where(station: station) if station
    filtered_orders
  end
end
