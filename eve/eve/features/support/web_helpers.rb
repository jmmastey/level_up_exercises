def current_path_with_query
  uri = URI.parse(current_url)
  "#{uri.path}?#{uri.query}"
end
