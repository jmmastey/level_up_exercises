module DinosaurIndex
  class Catalog
    include Enumerable

    attr_accessor :all_dinosaurs, :filters

    def initialize
      @all_dinosaurs, @filters = [], []
    end

    def add_dinosaur(*dinosaurs)
      @all_dinosaurs.push(*dinosaurs)
    end

    def <<(dinosaur)
      add_dinosaur(dinosaur)
    end

    def add_filter(&test_code)
      @filters << ->(dinosaur) { dinosaur.instance_eval(&test_code) }
    end

    def each
      @all_dinosaurs.select do |dinosaur|
        yield dinosaur if passes_filters?(dinosaur)
      end
    end

    def passes_filters?(dinosaur)
      @filters.all? { |filter| filter.call(dinosaur) }
    end
  end
end
