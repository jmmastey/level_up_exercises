Rails.application.routes.draw do
  get '/', to: 'trips#new'

  resources :trips do
    get 'flights_search'
    post 'show'
  end
end
