module RedditCast
  class Show
    attr_accessor :title, :youtubeid

    def initialize(show: nil, title: "", url: "")
      if !!show
        init_from_model(show)
      else
        init_from_json(title, url)
      end
    end

    def init_from_model(show)
      @title = show.title
      @youtubeid = show.youtubeid
    end

    def init_from_json(title, url)
      @title = title
      @youtubeid = url[/(?<=v=).{11}/]
    end

    def short_title
      short = title[0..50]
      short += "..." if(short.length < title.length)
      short
    end

    def to_s
      "#<Show: id=#{youtubeid} title=#{short_title}>"
    end

    def inspect
      to_s
    end
  end
end