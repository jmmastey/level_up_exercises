json.array! @results do |result|
  json.extract! result, :bioguide_id, :birthday, :chamber, :party, :title, :term_start, :term_end, :gender, :first_name, :nickname, :middle_name, :last_name, :state, :twitter_id, :facebook_id, :created_at, :updated_at, :phone, :website, :office, :contact_form
end