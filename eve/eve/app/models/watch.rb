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

  def max_price
    orders.maximum(:price)
  end

  def min_price
    orders.minimum(:price)
  end

  def orders
    @orders ||= fetch_orders
  end

  private

  def fetch_orders
    filters = {}
    filters[:region] = region if region
    filters[:station] = station if station

    Order.updated_for_item(item).where(filters)
  end
end
