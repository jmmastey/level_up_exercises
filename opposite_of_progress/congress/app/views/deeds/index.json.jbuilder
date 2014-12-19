json.array! @results do |result|
  json.extract! result, :deed, :occurrence_date
end
