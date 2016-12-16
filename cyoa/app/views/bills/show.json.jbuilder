json.partial! 'bill', bill: @bill

json.sponsor do
  json.partial! 'legislators/legislator', legislator: @bill.legislator
end

json.actions @bill_actions do |action|
  json.extract! action, :date, :text, :chamber, :result
end

json.important_actions @important_actions do |action|
  json.extract! action, :date, :text, :chamber, :result
end
