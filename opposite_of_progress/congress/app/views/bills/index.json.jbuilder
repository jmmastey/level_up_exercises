json.array! @results do |result|
  json.extract! result, :bill_id, :bill_type, :number, :congress, :chamber, :introduced_on, :last_action_at, :last_vote_at, :last_version_on, :official_title, :short_title, :summary, :summary_short, :sponsor_id, :enacted_at, :created_at, :updated_at
end