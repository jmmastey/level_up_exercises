json.page do
  json.total good_deeds.total_count
  json.count good_deeds.count
  json.current_page good_deeds.current_page
  json.total_pages good_deeds.total_pages
  json.prev "#{api_good_deeds_url}?page=#{good_deeds.prev_page}" unless good_deeds.prev_page.nil?
  json.next "#{api_good_deeds_url}?page=#{good_deeds.next_page}" unless good_deeds.next_page.nil?
end
