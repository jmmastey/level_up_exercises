# Adds artists to the database.
# Example usage: rake artist:add["Black Sabbath","Radiohead",.....]
namespace :artist do
  task add: :environment do |_task, args|
    args.extras.each do |subsequent|
      name = String(subsequent)
      message_user(Artist.search_spotify(name), name)
    end
  end

  def message_user(artist, name)
    if artist.nil?
      puts "Failed to add #{name} to the database. Ensure #{name} is on Spotify"
    else
      puts "Added #{name} to the database."
    end
  end
end
