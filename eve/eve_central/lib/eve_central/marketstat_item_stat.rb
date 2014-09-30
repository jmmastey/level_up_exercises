class MarketstatItemStat
  attr_accessor :average, :max, :min, :median, :percentile, :stddev, :volume

  def initialize(data)
    data.each do |key, value|
      method_name = "#{key}="
      send(method_name, value) if responds_to?(method_name)
    end
  end
end
