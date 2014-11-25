# URI example:
# http://example.com/users/123
# matches to
# http://example.com/users/124
uri_ignoring_trailing_id = lambda do |request_1, request_2|
  uri1, uri2 = request_1.uri, request_2.uri
  regexp_trail_id = %r(/\d+/?\z)
  if uri1.match(regexp_trail_id)
    r1_without_id = uri1.gsub(regexp_trail_id, "")
    r2_without_id = uri2.gsub(regexp_trail_id, "")
    uri1.match(regexp_trail_id) && uri2.match(regexp_trail_id) && r1_without_id == r2_without_id
  else
    uri1 == uri2
  end
end

describe "#upgrade", vcr: {match_requests_on: [:method, uri_ignoring_trailing_id]} do
  #...
end