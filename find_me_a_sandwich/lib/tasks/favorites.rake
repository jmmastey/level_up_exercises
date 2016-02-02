namespace :favorites do
  desc "Show all favorites by all users"
  task :show => :environment do
    favorites = Favorite.all
    favorites.each do |fave|
      puts "#{fave.menu_item.name} favorited by user #{fave.user.email}"
    end
  end
end