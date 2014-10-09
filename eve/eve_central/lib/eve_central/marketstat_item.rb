module EveCentral
  class MarketstatItem
    attr_reader :item_id, :buy_stats, :sell_stats, :all_stats

    def initialize(item_id, stats = {})
      @item_id = item_id
      @buy_stats = stats[:buy_stats]
      @sell_stats = stats[:sell_stats]
      @all_stats = stats[:all_stats]
    end
  end
end
