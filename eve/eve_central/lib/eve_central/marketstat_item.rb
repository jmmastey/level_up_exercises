class MarketstatItem
  attr_reader :id, :buy, :sell, :all

  def initialize(id, buy_result, sell_result, all_result)
    @id = id
    @buy = buy_result
    @sell = sell_result
    @all = all_result
  end
end
