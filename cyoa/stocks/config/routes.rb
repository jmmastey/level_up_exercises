Rails.application.routes.draw do
  devise_for :users
  resources :stocks

  root 'stocks#index'

  post 'watchlist/:id' => "watchlist#update"
  get 'watchlist' => "watchlist#index", as: "watchlist"

  get '/feed/:id' => 'watchlist#feed',
      :as => :feed,
      :defaults => { :format => 'atom' }
end
