# lib/tasks/jobs.rake
namespace :jobs do
  desc "Fill database with Job listings"
  task fetch: :environment do
    require 'nokogiri'
    require 'open-uri'

    # clean database to avoid duplicates
    Job.all.each do |job|
      job.destroy!
    end

    # write your nokogiri scripts here or
    #
    require 'lib/tasks/sites/theater_in_chicago'
    #
    # them from other files.

    # Throw away old jobs
    Job.destroy_all(['created_at < ?', 7.days.ago])
  end

  desc "Delete Jobs that are older than 7 days"
  task prune: :environment do
    Job.destroy_all(['created_at < ?', 7.days.ago])
  end

  desc "Delete all jobs."
  task clean: :environment do
    Job.all.each do |job|
      job.destroy!
    end
  end

end
