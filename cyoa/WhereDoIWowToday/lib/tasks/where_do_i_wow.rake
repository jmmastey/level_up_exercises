namespace :where_do_i_wow do
  desc "Populate more quest info by calling Blizzard's rate-restricted API"
  task populate_more_quests: :environment do
    puts "Fetching quests..."
    Quest.populate_next_batch
  end
end
