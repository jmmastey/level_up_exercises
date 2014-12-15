Rails.application.routes.draw do
  get '/', to: 'trips#new'

  resources :trips do
    get 'flights_search'
    get 'show'
    post 'flights_save'
  end
end
