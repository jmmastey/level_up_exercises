atom_feed :language => 'en-US' do |feed|
  feed.title @title
  feed.updated @updated

  @watched_stocks.each do |stock|
    next if stock.created_at.blank?

    feed.entry( stock ) do |entry|
      entry.url stock_url(stock)
      entry.title stock.symbol
      entry.content stock.rating, :type => 'html'

      entry.updated(stock.created_at.strftime("%Y-%m-%dT%H:%M:%SZ")) 
    end
  end
end