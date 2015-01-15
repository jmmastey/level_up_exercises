json.results do
  json.array! @bills, partial: 'bills/bill', as: :bill
end

json.partial! 'bills/pagination', bills: @bills
