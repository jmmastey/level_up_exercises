Rails.application.routes.draw do
  devise_for :users
  root             'static_pages#home'
  get 'help'    => 'static_pages#help'
  get 'about'   => 'static_pages#about'
  get 'movies'  => 'movies#new'
end
