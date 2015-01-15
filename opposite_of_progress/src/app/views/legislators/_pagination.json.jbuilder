json.page do
  json.total legislators.total_count
  json.count legislators.count
  json.current_page legislators.current_page
  json.total_pages legislators.total_pages
  json.prev "#{api_legislators_url}?page=#{legislators.prev_page}" unless legislators.prev_page.nil?
  json.next "#{api_legislators_url}?page=#{legislators.next_page}" unless legislators.next_page.nil?
end
