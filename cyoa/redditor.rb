require 'httparty'
require 'json'

class Redditor
  include HTTParty
  base_uri "https://ssl.reddit.com"
  headers 'User-Agent' => 'Reddit Remote'

  def initialize(user, pass)
    log_in(user, pass)
  end

  def log_in(user, pass)
    params = {user: user, 
              passwd: pass, 
              api_type: 'json'}

    res = self.class.post("/api/login", :body => params)
    Redditor.default_cookies.add_cookies res.headers['set-cookie']
  end

  def posts(subreddit)
    params = {t: 'day', 
              count: 10,
              limit: 10}

    res = self.class.get("/r/#{subreddit}/top.json", :body => params)
    puts res
  end
end

reddit = Redditor.new('redditor000985', 'password')
reddit.posts('fo4')