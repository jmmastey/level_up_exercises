# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

puts "(1) Emptying tables..."
Channel.delete_all
SearchSet.delete_all
Search.delete_all
Show.delete_all
User.delete_all
UserChannel.delete_all

puts "(2) Reading in json file..."
channel_information = open('channels.json', &:read)
parsed = JSON.parse(channel_information)

puts "(3) Building channels..."
@listings = parsed['channels'].map do |json|
  puts "\tCreating channel #{json['name']}..."

  channel = Channel.new.init_from_http(json['name'], json['queries'], true)
  channel.search_set.save
  channel.search_set.searches.each(&:save)
end
