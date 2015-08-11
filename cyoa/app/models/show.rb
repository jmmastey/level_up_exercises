class Show < ActiveRecord::Base
  belongs_to :search
  validates_uniqueness_of :youtubeid, scope: :search_id

  def short_title
    short = self.title[0..50]
    short += "..." if(short.length < self.title.length)
    short
  end

  def thumbnail
    "http://img.youtube.com/vi/#{youtubeid}/hqdefault.jpg"
  end

  def to_s
    "#<Show: id=#{self.youtubeid} title=#{short_title}>"
  end

  alias_method :inspect, :to_s
end
