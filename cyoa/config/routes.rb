Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "registrations" }

  get "/channel/status",   to: "channel#status"
  post "/channel/create",  to: "channel#create"
  post "/channel/destroy", to: "channel#destroy"

  get "/show/next",    to: "reddit_cast#next_show"
  get "/show/prev",    to: "reddit_cast#prev_show"
  get "/channel/next", to: "reddit_cast#next_channel"
  get "/channel/prev", to: "reddit_cast#prev_channel"
  get "/channel/to",   to: "reddit_cast#to_channel"
  get "/channel",      to: "reddit_cast#now_showing"
  
  root 'reddit_cast#index'
end
