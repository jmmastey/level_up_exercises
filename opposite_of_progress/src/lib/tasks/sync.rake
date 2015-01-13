namespace :sync do
  desc "TODO"
  task legislators: :environment do
    CongressApiService.sync_legislators
  end
end
