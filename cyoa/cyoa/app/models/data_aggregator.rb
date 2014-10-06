class DataAggregator
  attr_reader :grooveshark

  def initialize
    @grooveshark = Grooveshark::Client.new
  end

  def store_grooveshark_data
    top_today
  end

  def get_popular_songs(options = {})
    limit = options[:limit] || 10
    scope = options[:scope] || "daily"

    grooveshark.popular_songs(scope).take(limit)
  end
end
