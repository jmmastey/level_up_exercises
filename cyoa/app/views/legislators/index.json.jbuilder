json.search_query params[:query]
json.legislators @legislators do |legislator|
  json.extract! legislator, :title, :first_name, :middle_name, :last_name, :name_suffix, :nickname, :party, :state, :district, :gender, :phone, :fax, :website, :contact_form, :office, :bioguide_id, :votesmart_id, :twitter_id, :youtube_id, :facebook_id, :birthday, :in_office
end
