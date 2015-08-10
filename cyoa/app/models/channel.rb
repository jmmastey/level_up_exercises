class Channel < ActiveRecord::Base
  has_one :search_set
  has_many :user_channels
  has_many :users, through: :user_channels

  def init_from_http(ch_name, ch_tags, default = false)
    self.name = ch_name
    self.default = default;
    self.search_set = SearchSet.new.init_from_http(ch_tags)
    save
    self
  end

  def next?
    search_set.next?
  end

  def previous?
    search_set.previous?
  end

  def next
    return unless next?
    search_set.next
    now_showing
  end

  def previous
    return unless previous?
    search_set.previous
    now_showing
  end

  def now_showing
    search_set.current_listing
  end

  def to_s
    "#<Channel: name='#{name}'>"
  end

  alias_method :next_show, :next
  alias_method :prev_show, :previous
  alias_method :inspect, :to_s
end
