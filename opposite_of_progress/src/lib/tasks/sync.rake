namespace :sync do
  desc "Sync legislators"
  task legislators: :environment do
    puts 'Syncing legislators with Congress API started'
    CongressApiService.sync_legislators
    puts 'Syncing legislators with Congress API ended'
  end

  task bills: :environment do
    puts 'Syncing bills with Congress API started'
    CongressApiService.sync_bills
    puts 'Syncing bills with Congress API ended'
  end
end
