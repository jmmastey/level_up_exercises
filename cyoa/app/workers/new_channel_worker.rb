class NewChannelWorker
  include Sidekiq::Worker

  def perform(params, count)
    puts "Creating channel #{params["name"]}..."

    channel = Channel.new.init_from_http(params["name"], params["tags"])
    channel.search_set.save
    channel.search_set.searches.each(&:save)

    User.find(params["user"]).channels << channel
  end
end