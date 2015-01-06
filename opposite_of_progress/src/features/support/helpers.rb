def assert_path(path)
  current_path = URI.parse(current_url).path
  expect(current_path).to eq(path)
end
