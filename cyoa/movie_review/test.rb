require 'net/http'
require 'json'

MY_API_KEY = '7f052176a77b44b47431f908b840ace8'
uri = 'http://api.themoviedb.org/3/configuration?api_key=' << MY_API_KEY

puts uri
uri = URI(uri)
response = Net::HTTP.get_response(uri)
result = JSON.parse(response.body) if response.is_a?(Net::HTTPSuccess)

result = result['images']
puts result['base_url'] << result['logo_sizes'][1]


uri = URI('http://api.themoviedb.org/3/movie/popular?api_key=7f052176a77b44b47431f908b840ace8')
response = Net::HTTP.get_response(uri)
result = JSON.parse(response.body) if response.is_a?(Net::HTTPSuccess)

result = result['results']
result.each do |r|
  puts r['title']
end
