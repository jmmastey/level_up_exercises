json.extract! bill, :id
json.official_id bill.official_id.try(:upcase)
json.extract! bill, :official_title
json.official_url bill.url
json.url api_bill_url(bill)
json.extract! bill, :updated_at, :created_at
