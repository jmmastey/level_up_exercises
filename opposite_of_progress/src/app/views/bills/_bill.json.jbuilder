json.extract! bill, :id
json.official_id bill.official_id.try(:upcase)
json.merge! bill.attributes.except('id', 'updated_at', 'created_at', 'official_id', 'url')
json.official_url bill.url
json.url api_bill_url(bill)
json.extract! bill, :updated_at, :created_at

if bill.sponsorships.present?
  json.sponsors do
    json.partial! 'legislators/legislator_minimal', collection: bill.sponsorships.map(&:legislator), as: :legislator
  end
end

if bill.cosponsorships.present?
  json.cosponsors do
    json.partial! 'legislators/legislator_minimal', collection: bill.cosponsorships.map(&:legislator), as: :legislator
  end
end
