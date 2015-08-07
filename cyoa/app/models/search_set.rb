class SearchSet < ActiveRecord::Base
  belongs_to :channel
  has_many :searches
  LIMIT = 20

  def init_from_http(queries)
    self.listing = -1

    limit = LIMIT / queries.count
    queries.each do |search_query|
      searches.new.init_from_http(search_query, limit)
    end
    self
  end

  def queries
    searches.map(&:query)
  end

  def num_results
    searches.inject(0) do |sum, search|
      sum + search.shows.count
    end
  end

  def next?
    self.searches.any?(&:next?)
  end

  def previous?
    self.listing > -1
  end

  def next
    return unless next?
    
    loop do
      self.listing += 1
      break if searches[self.listing % searches.count].next?
      break unless next?
    end

    searches[self.listing % searches.count].next
    current_listing
  end

  def previous
    return unless previous?
    searches[self.listing % searches.count].previous

    loop do
      self.listing -= 1
      break if searches[self.listing % searches.count].previous?
      break unless previous?
    end

    current_listing
  end

  def to_s
    str = "#<SearchSet: queries='#{queries}' "
    str << "results=#{num_results} "
    str << "next?=#{next?} "
    str << "previous?=#{previous?}>"
  end

  def current_listing
    searches[self.listing % searches.count].current_listing
  end

  alias_method :inspect, :to_s
end
