require "json"
require "date"

require_relative "page_view"

class ViewParser
  def parse(json)
    items = JSON.parse(json)
    items.map do |item|
      unmarshal(item)
    end
  end

  private

  def unmarshal(item)
    date = Date.parse(item["date"])
    id = item["cohort"]
    purchased = purchased?(item["result"])

    PageView.new(date: date, id: id, purchased: purchased)
  end

  def purchased?(result)
    result == 1
  end
end
