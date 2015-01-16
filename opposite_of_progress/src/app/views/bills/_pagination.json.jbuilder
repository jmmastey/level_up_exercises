json.page do
  json.total bills.total_count
  json.count bills.count
  json.current_page bills.current_page
  json.total_pages bills.total_pages
  json.prev "#{api_bills_url}?page=#{bills.prev_page}" unless bills.prev_page.nil?
  json.next "#{api_bills_url}?page=#{bills.next_page}" unless bills.next_page.nil?
end
