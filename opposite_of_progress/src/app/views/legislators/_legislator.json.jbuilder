json.extract! legislator, :id, :bioguide_id
json.name legislator.name_with_title
json.representation representation(legislator)
json.extract! legislator, :first_name, :last_name, :middle_name, :name_suffix, :title, :chamber, :party
json.state_abbr legislator.state
json.state States.abbr_to_state(legislator.state)
json.extract! legislator, :district, :state_rank, :phone
json.facebook facebook_url(legislator)
json.twitter twitter_url(legislator)
json.youtube youtube_url(legislator)
json.url api_legislator_url(legislator)
json.extract! legislator, :created_at, :updated_at

if legislator.sponsorships.present?
  json.sponsorships do
    json.partial! 'bills/bill_minimal', collection: legislator.sponsorships.map(&:bill), as: :bill
  end
end

if legislator.cosponsorships.present?
  json.cosponsorships do
    json.partial! 'bills/bill_minimal', collection: legislator.cosponsorships.map(&:bill), as: :bill
  end
end
