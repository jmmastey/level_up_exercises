require "active_model"

module EveCentral
  class Order
    include ActiveModel::Validations
    include ActiveModel::Conversion
    extend ActiveModel::Naming

    attr_accessor :id, :region_id, :station, :security, :price,
      :volume_remaining, :min_volume, :expires, :reported_time

    validates_presence_of :id
    validates_numericality_of :id, :region_id, :volume_remaining, :min_volume, only_integer: true, greater_than_or_equal_to: 0, allow_nil: true
    validates_numericality_of :price, greater_than_or_equal_to: 0, allow_nil: true
    validates_numericality_of :security, allow_nil: true, greater_than_or_equal_to: -1.0, less_than_or_equal_to: 1.0

    def initialize(id)
      self.id = id
    end

    def expired?
      expires <= Time.now.utc
    end

    def persisted?
      false
    end
  end
end
