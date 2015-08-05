# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

puts "Emptying tables..."
Channel.delete_all
SearchSet.delete_all
Search.delete_all
Show.delete_all

puts "Reading in json file..."
tv = RedditCast::TV.new(json_file: 'channels.json')

puts "Parsing http results..."
tv.channels.each do |rc_channel|
  # Create channel in db
  ch = Channel.create(name: rc_channel.name)

  # Create search set in db
  ss = SearchSet.create(listing: 0)

  # Cache searches in db
  rc_channel.listings.searches.each do |rc_search|
    params = {}
    params[:before] = rc_search.before
    params[:after] = rc_search.after
    params[:query] = rc_search.query
    params[:listing] = rc_search.listing_number
    
    # Cache channel shows in db to quickly load search results
    search = ss.searches.create(params)

    rc_search.listings.each do |show|
      search.shows.create(title: show.short_title, youtubeid: show.youtubeid)
    end
  end


  ch.search_set = ss
  ch.save
end

