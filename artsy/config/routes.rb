Rails.application.routes.draw do

  devise_scope :user do
    get 'signup' => 'devise/registrations#new'
    get 'login' => 'devise/sessions#new'
    get 'users' => 'users#index'
  end

  devise_for :users, :controllers => { :registrations => :registrations }

  get 'static_pages/home'

  root 'static_pages#home'

  get 'users/:id' => 'users#show', as: :user

  get 'search/artist' => 'search_for#artist', as: :search_for_artist

  resources :artists do
    resources :favorites
    resources :artworks
  end
end
