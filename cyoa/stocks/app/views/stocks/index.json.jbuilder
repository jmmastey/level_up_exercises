json.array!(@stocks) do |stock|
  json.extract! stock, :id, :symbol, :name, :sector, :industry
  json.url stock_url(stock, format: :json)
end
