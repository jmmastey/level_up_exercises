Rails.application.routes.draw do
  root 'welcome#index'
  post 'scrape' => 'scrape#index'
  delete 'sessions/:id' => 'sessions#destroy', as: :logout

  resources :users, only: [:new, :create, :show]
  resources :sessions, only: [:new, :create, :destroy]
  resources :events, only: [:index, :show]
  resources :showings, only: [:show, :destroy]

  post 'showings/:id' => 'showings#add', as: :add
end
