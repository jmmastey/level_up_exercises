class TVWorker
  include Sidekiq::Worker

  def perform(tv, count)
    puts "--- ACTIVATING MY SIDEKIQ ---"
    tv.channel.listings.next_listing
  end
end