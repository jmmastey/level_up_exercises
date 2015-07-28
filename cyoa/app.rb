require 'sinatra'
require 'sinatra/base'
require 'json'
require './classes/reddit_cast.rb'
require './classes/show.rb'

class RCServer < Sinatra::Base

  set :port, 8008
  enable :sessions

  get '/' do
    # session[:reddit_cast] = RedditCast.new unless session[:reddit_cast]
    session[:shows] = [%w(iEtQeoTpf-g
                        kdmd5fenroU
                        W6cM3XvD124
                        V_Nr31Lv6H8),
                        %w(BYf8Ra3eWi8
                        fA_7xHIsk48
                        AmKw7Oqmhr0
                        w3LZIddqk5A
                        9s_sHcJsLHg
                        zbm1kJzdv1M),
                        %w(kz0yRHp5SUM
                        yOwdwh5o0wA
                        b9DMiy_DVok
                        02ddnGzxNZs
                        quSF4rEgxhU
                        0e7b1qeFcww),
                        %w(IXMSbmhcc6A
                        dx3x4h8BHG0
                        32E_eh5KZps
                        DEuVAGPFXsI
                        HOuo_3UmIuE
                        mYkB5f1X-yM),
                        %w(J92MxvIANEQ
                        oapgiZc5i-g
                        2LqzF5WauAw
                        wyE1m3uui-A
                        PuNymhcTtSQ
                        3WtgmT5CYU8)]
    session[:channels] = ["Cats", "Comedy", "Weather", "game Show", "Space"]
    session[:channel] = 0
    session[:show] = 0

    haml :index, locals: locals
  end

  get "/nextshow" do
    session[:show] = (session[:show] + 1) % session[:shows].count

    content_type :json
    locals.to_json
  end

  get "/prevshow" do
    session[:show] = (session[:show] - 1) % session[:shows].count

    content_type :json
    locals.to_json
  end

  get "/prevchannel" do
    session[:channel] = (session[:channel] - 1) % session[:channels].count
    session[:show] = 0

    content_type :json
    locals.to_json
  end

  def locals
    prefix = session[:channel] < 9 ? "0" : ""
    youtube_link = "#{Show::YOUTUBE}#{show}?showinfo=0"

    { 
      name: channel_name, 
      number: "#{prefix}#{session[:channel] + 1}", 
      show: youtube_link
    }
  end

  def channel_name
    session[:channels][session[:channel]]
  end

  def show
    session[:shows][session[:channel]][session[:show]]
  end
end

RCServer.run!