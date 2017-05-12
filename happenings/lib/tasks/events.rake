# lib/tasks/jobs.rake
namespace :events do
  desc "Fill database with Job listings"
  task fetch: :environment do
    require 'nokogiri'
    require 'open-uri'

    # clean database to avoid duplicates
    # Job.all.each do |job|
    #   job.destroy!
    # end

    # write your nokogiri scripts here or
    #
    require_relative 'sites/theatre_scraper'
    TheatreScraper.new
    #
    # them from other files.

    # Throw away old jobs
    # Job.destroy_all(['created_at < ?', 7.days.ago])
  end

  desc "Delete Events that are older than 7 days"
  task prune: :environment do
    Event.destroy_all(['created_at < ?', 7.days.ago])
  end

  desc "Delete all Events."
  task clean: :environment do
    Event.all.each(&:destroy!)
  end

end
