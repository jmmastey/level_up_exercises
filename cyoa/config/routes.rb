Rails.application.routes.draw do
  get 'channel/new'
  get 'channel/create'
  get 'channel/show'
  get 'channel/edit'
  get 'channel/update'

  get "/nextshow",    to: "reddit_cast#next_show"
  get "/prevshow",    to: "reddit_cast#prev_show"
  get "/nextchannel", to: "reddit_cast#next_channel"
  get "/prevchannel", to: "reddit_cast#prev_channel"
  get "/to_channel", to: "reddit_cast#to_channel"
  get "/now_showing", to: "reddit_cast#now_showing"

  root 'reddit_cast#index'

end
