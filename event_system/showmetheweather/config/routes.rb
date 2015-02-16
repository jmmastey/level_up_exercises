Rails.application.routes.draw do
  devise_for :users
  root 'forecasts#index'
  get 'forecasts/index'
  post 'forecasts/search'
  get 'forecasts/show/:zip_code', to: 'forecasts#show', as: 'forecasts_show'
end
