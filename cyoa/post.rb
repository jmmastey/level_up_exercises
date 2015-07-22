class Post
  attr_accessor :author, :title, :youtube_link, :youtube_id

  def initialize(json_post)
    @author = json_post['author']
    @title = json_post['title']
    @nsfw = json_post['over_18']

    @youtube_link = json_post['url']
    @youtube_id = @youtube_link[/(?<=v=).+$/]
  end

  def nsfw?
    @nsfw
  end

  def to_s
    formatted_string = "#{@title}\n"
    formatted_string += "(by /u/#{@author}) #{@youtube_link}\n\n"
  end
end