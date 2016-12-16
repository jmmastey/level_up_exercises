require 'csv'

namespace :load do
  desc 'Load Congressional districts from csv'
  task districts: :environment do
    header = %w(zipcode state congressional_district_id)
    CSV.foreach('districts.csv') do |row|
      CongressionalDistrict.create(Hash[header.zip(row)])
    end
  end

  desc 'Load legislators from SunlightlabsApi'
  task legislators: :environment do
    include SunlightlabsApi
    get_legislators_from_api
  end

  desc 'Load bills from SunlightlabsApi'
  task bills: :environment do
    include SunlightlabsApi
    get_bills_from_api
  end
end

desc 'Update bills from API'
task update_bills: :environment do
  include SunlightlabsApi
  get_bills_from_api
end
