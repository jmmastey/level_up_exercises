class Watch < ActiveRecord::Base
  belongs_to :user
  belongs_to :item
  belongs_to :region
  belongs_to :station

  validates_presence_of :item, :user
  validates_with LocationFilterValidator

  before_validation(:check_nickname)

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

  def check_nickname
    nickname = default_nickname if nickname.blank?
  end

  def default_nickname
    return nickname unless nickname.blank?

    location = region || station

    begin
      return "#{item.name} in #{location.name}"
      "#{item.name}"
    rescue NoMethodError
      nil
    end
  end

  def fetch_orders
    filters = {}
    filters[:region] = region if region
    filters[:station] = station if station

    Order.updated_for_item(item).where(filters)
  end
end
