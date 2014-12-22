require "active_model"

module EveCentral
  class Order
    include ActiveModel::Validations
    include ActiveModel::Conversion
    extend ActiveModel::Naming

    attr_accessor :id,
                  :region_id,
                  :station_id,
                  :station_name,
                  :security,
                  :price,
                  :volume_remaining,
                  :min_volume,
                  :expires

    validates_presence_of :id
    validates_numericality_of :id,
                              :region_id,
                              :station_id,
                              :volume_remaining,
                              :min_volume,
                              only_integer: true,
                              greater_than_or_equal_to: 0,
                              allow_nil: true
    validates_numericality_of :price,
                              greater_than_or_equal_to: 0,
                              allow_nil: true
    validates_numericality_of :security,
                              allow_nil: true,
                              greater_than_or_equal_to: -1.0,
                              less_than_or_equal_to: 1.0

    def initialize(order_data = {})
      @expires = order_data[:expires]
      @id = order_data[:id]
      @min_volume = order_data[:min_volume]
      @price = order_data[:price]
      @region_id = order_data[:region_id]
      @security = order_data[:security]
      @station_id = order_data[:station_id]
      @station_name = order_data[:station_name]
      @volume_remaining = order_data[:volume_remaining]
    end

    def expired?
      expires <= Time.now.utc
    end

    def persisted?
      false
    end
  end
end
