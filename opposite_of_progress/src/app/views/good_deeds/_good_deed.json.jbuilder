json.extract! good_deed, :id

if good_deed.action.in? %w(sponsored cosponsored)
  json.description "#{good_deed.legislator.name_with_title} (#{good_deed.legislator.party}-#{good_deed.legislator.state}) #{good_deed.action.titleize} #{good_deed.bill.title_with_id}"
elsif good_deed.action == 'voted'
  json.description "#{good_deed.chamber.titleize} passed #{good_deed.bill.title_with_id}"
else
  json.description "Enacted as #{good_deed.text}"
end

json.merge! good_deed.attributes.except('id', 'created_at', 'updated_at')
json.url api_good_deed_url(good_deed)
json.extract! good_deed, :created_at, :updated_at
if good_deed.legislator.present?
  json.legislator do
    json.partial! 'legislators/legislator_minimal', legislator: good_deed.legislator
  end
end

json.bill do
    json.partial! 'bills/bill_minimal', bill: good_deed.bill
end

