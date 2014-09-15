require "json"

require_relative "pageview"

class ViewParser
  def parse(json)
    items = JSON.parse(json)
    items.map do |item|
      build_pageview(item)
    end
  end

  private

  def build_pageview(item)
    date = Date.parse(item["date"])
    id = item["cohort"]
    purchased = purchased?(item["result"])

    PageView.new(date: date, id: id, purchased: purchased)
  end

  def purchased?(result)
    result == 1
  end
end
