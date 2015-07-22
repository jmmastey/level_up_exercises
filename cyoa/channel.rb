require './search_set.rb'

class Channel
  
  attr_accessor :name, :queries, :shows

  def initialize(json_channel)
    @name = json_channel['name']
    @queries = json_channel['queries']

    @shows = SearchSet.new(queries)
  end

  def add_query(query)
    queries << query
  end

  def show_next

  end

  def show_prev

  end
end