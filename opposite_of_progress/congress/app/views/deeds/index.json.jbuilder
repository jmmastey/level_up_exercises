json.array! @results do |result|
  json.extract! result, :deed, :date
end
