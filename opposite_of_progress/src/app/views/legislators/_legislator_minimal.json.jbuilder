json.extract! legislator, :id, :bioguide_id
json.name legislator.name_with_title
json.representation representation(legislator)
json.url api_legislator_url(legislator)
json.extract! legislator, :created_at, :updated_at
