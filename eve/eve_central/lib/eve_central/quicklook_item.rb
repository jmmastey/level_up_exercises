require "active_model"

module EveCentral
  class QuicklookItem
    include ActiveModel::Validations
    include ActiveModel::Conversion
    extend ActiveModel::Naming

    attr_accessor :item, :buy_orders, :sell_orders

    validates_presence_of :item, :buy_orders, :sell_orders
    validate :validate_item, :validate_buy_orders, :validate_sell_orders

    def initialize(data = {})
      @item = data[:item]
      @buy_orders = data[:buy_orders]
      @sell_orders = data[:sell_orders]
    end

    def buy_orders_valid?
      buy_orders && buy_orders.all?(&:valid?)
    end

    def sell_orders_valid?
      sell_orders && sell_orders.all?(&:valid?)
    end

    def validate_item
      errors.add(:item, "is not valid") if item && !item.valid?
    end

    def validate_buy_orders
      errors.add(:buy_orders, "contains invalid order") unless buy_orders_valid?
    end

    def validate_sell_orders
      errors.add(:sell_orders, "contains invalid order") unless sell_orders_valid?
    end
  end
end
