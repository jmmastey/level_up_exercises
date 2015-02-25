namespace :stocks do
  task :import_symbols => :environment do
    CSV.foreach('public/smallcompanylist.csv', headers: true) do |row|
      Stock.create(
        :symbol => row['Symbol'],
        :name => row['Name'],
        :sector => row['Sector'],
        :industry => row['Industry']
      )
    end
  end

  task :import_data => :environment do
    symbols = Stock.all.map(&:symbol)
    fields = [:symbol, :ask, :bid, :ticker_trend, :moving_average_200_day, :moving_average_50_day, :pe_ratio, :peg_ratio, :market_capitalization]
    data = YahooFinance.quotes(symbols, fields)

    data.each do |row|
      stock = Stock.all.select { |stock| stock.symbol == row.symbol }.first
      next unless stock
      stock.update_attributes(
        asking_price: row.ask,
        bid_price: row.bid,
        ticker_trend: row.ticker_trend,
        moving_average_200_day: row.moving_average_200_day,
        moving_average_50_day: row.moving_average_50_day,
        pe_ratio: row.pe_ratio,
        peg_ratio: row.peg_ratio,
        market_cap: row.market_capitalization
      )
    end
  end
end

task :import_stocks do
  Rake::Task['stocks:import_symbols'].invoke
  Rake::Task['stocks:import_data'].invoke
end
