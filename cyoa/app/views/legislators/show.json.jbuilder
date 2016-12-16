json.partial! 'legislator', legislator: @legislator

json.sponsored @legislator.bills do |bill|
  json.partial! 'bills/bill', bill: bill
end
