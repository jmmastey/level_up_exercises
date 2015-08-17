class Search < ActiveRecord::Base
  include HTTParty
  belongs_to :search_set
  has_many :shows
  base_uri "http://www.reddit.com"

  def init_from_http(search_query, limit)
    self.after, self.before = '', ''
    self.listing = 0
    self.query = search_query
    @limit = limit
    load_results_page
    self
  end

  def next?
    self.listing < shows.count || after != ''
  end

  def previous?
    self.listing > 0
  end

  def has_post?
    self.listing >= 0 && self.listing < shows.count
  end

  def next
    return unless next?

    self.listing += 1
    if(self.listing == shows.count)
      load_results_page(next_or_prev: 'next')
    end
    current_listing
  end

  def previous
    return unless previous?

    self.listing  -= 1
    current_listing
  end

  def to_s
    "#<Search: query='#{query}'>"
  end

  def current_listing
    shows[self.listing]
  end

  alias_method :inspect, :to_s

  private

  def api_query
    "site:youtube.com nsfw:no #{query}"
  end

  def load_results_page(depth = 10, next_or_prev: 'next')
    raise "Could not connect to Reddit." if depth == 0

    response = self.class.get("/search.json", query: search_params(next_or_prev))
    if response && response['data']
      parse_response(response['data'])
    else
      load_results_page(depth - 1) 
    end
    save
  end

  def search_params(next_or_prev)
    http_params = { q: api_query, limit: @limit }

    if next_or_prev == 'next'
      http_params[:after] = after
    else
      http_params[:before] = before
    end

    http_params
  end

  def parse_response(json_response)
    self.after = json_response['after']
    parse_before_link(json_response)

    json_response['children'].map do |child| 
      title = child['data']['title']
      youtubeid = child['data']['url'][/(?<=v=).{11}/]

      self.shows.build(title: title, youtubeid: youtubeid)
    end
  end

  def parse_before_link(json_response)
    if self.listing == 0
      self.before = ''
    elsif json_response['children'].count == 0
      self.before = ''
    else
      first_post = json_response['children'][0]
      self.before = first_post['data']['before']
    end
  end

end