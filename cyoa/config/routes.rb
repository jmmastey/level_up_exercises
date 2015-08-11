Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations' }
  get '/users/:id', to: 'users#show', as: "user_profile"

  get '/ebooks/error', to: 'ebooks#error', as: "ebook_error"
  get '/ebooks/my', to: 'ebooks#my_books', as: "my_ebooks"
  get '/ebooks/:id/download', to: 'ebooks#download', as: "ebook_download"
  resources :ebooks

  get '/', to: 'static#index', as: "home"
end
