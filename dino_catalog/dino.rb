class Dino
  attr_reader :name, :period, :continent, :diet, :weight, :walking, :description

  def initialize(options = {})
    @name        = options[:name]
    @period      = options[:period]
    @continent   = options[:continent]
    @diet        = options[:diet]
    @weight      = options[:weight]
    @walking     = options[:walking]
    @description = options[:description]
  end

  def to_s
    "#{@name} #{@period} #{@continent} #{@diet} #{@weight} #{@walking} #{@description}"
  end
end
