module EveCentral
  class Order
    include ActiveModel::Validations
    include ActiveModel::Conversion
    extend ActiveModel::Naming

    attr_accessor :id, :region_id, :station, :security, :price,
      :volume_remaining, :min_volume, :expires, :reported_time

    validates_presence_of :id
    validates :id, :region_id, :volume_remaining, :min_volume, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
    validates :security, :price, numericality: true

    def initialize(id)
      @errors = ActiveRecord::Errors.new(self)
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
