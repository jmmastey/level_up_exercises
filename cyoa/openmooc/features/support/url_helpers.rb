def current_path
  URI.parse(String.new(current_url)).path
end
