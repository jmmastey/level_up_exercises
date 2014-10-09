module EveCentral
  class Station
    attr_reader :id, :name

    def initialize(id, name = nil)
      @id = id
      @name = name
    end
  end
end
