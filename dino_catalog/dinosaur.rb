class Dinosaur
  attr_accessor :name, :period, :continent, :diet, :weight, :walking,
                :description
  attr_reader :to_hash

  def initialize(args = {})
    @to_hash     = args
    @name        = args[:name]
    @period      = args[:period]
    @continent   = args[:continent]
    @diet        = args[:diet]
    @weight      = args[:weight]
    @walking     = args[:walking]
    @description = args[:description]
  end
end
