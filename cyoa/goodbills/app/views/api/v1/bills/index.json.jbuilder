json.array! @bills do |bill|
  json.official_title bill.official_title
  json.score bill.score
  json.num_voted bill.num_voted
end