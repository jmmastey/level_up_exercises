namespace :vcr do
  desc "Clears out VCR cassettes"
  task clear: :environment do
    FileUtils.rm_rf("#{Rails.root}/features/support/fixtures/vcr")
  end
end
