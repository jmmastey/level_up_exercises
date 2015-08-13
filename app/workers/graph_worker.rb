class GraphWorker
  include Sidekiq::Worker

  def perform(name, depth)
    Artist.search(name, depth)
  end
end