class Post
  attr_accessor :author, :title, :youtube_link, :youtube_id

  def initialize(json_post)
    @author = json_post['author']
    @title = json_post['title']
    @nsfw = json_post['over_18']

    @youtube_link = json_post['url']
    @youtube_id = @youtube_link[/(?<=v=).{11}$/]
  end

  def nsfw?
    @nsfw
  end

  def to_s
    shorter_title = @title[0..20]
    shorter_title += "..." if(shorter_title.length < @title.length)

    "#<Post: id=#{@youtube_id} title=#{shorter_title} author=#{@author}>"
  end

  def inspect
    to_s
  end
end