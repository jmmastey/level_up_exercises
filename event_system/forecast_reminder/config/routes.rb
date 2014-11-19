Rails.application.routes.draw do
  devise_for :users
  get 'forecast/index'
  root 'forecast#index'
end
