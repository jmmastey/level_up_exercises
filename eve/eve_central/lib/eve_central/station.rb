require "active_model"

module EveCentral
  class Station
    include ActiveModel::Validations
    include ActiveModel::Conversion
    extend ActiveModel::Naming

    attr_accessor :id, :name

    validates_presence_of :id
    validates_numericality_of :id, only_integer: true, greater_than_or_equal_to: 0

    def initialize(id, name = nil)
      @id = id
      @name = name
    end

    def persisted?
      false
    end
  end
end
