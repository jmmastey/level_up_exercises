namespace :brew do
  task :cards => :environment do
    DeckBrew.new.load_all_cards
  end

  task :types => :environment do
    DeckBrew.new.load_all_types
  end

  task :sets => :environment do
    DeckBrew.new.load_all_sets
  end

  task :new_cards => :environment do
    DeckBrew.new.load_new_cards
  end

  task :all => :environment do
    # Types and sets are automatically loaded with cards.
    DeckBrew.new.load_all_cards
  end
end
