Rails.application.routes.draw do
  resources :event_sources
  resources :events
 
  get "/feeds", to: redirect("/my-feeds")
   
  resources :feeds do
    resources :selection_criteria
    resources :event_sources, only: :index
  end

  root to: "site#home"

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
  } 

  devise_scope :user do
    get "/users/sign_out", to: "users/sessions#destroy"
  end

  get "/about-us", to: "site#about_us", as: :about_us
  get "/contact-us", to: "site#contact_us", as: :contact_us
  get "/privacy-policy", to: "site#privacy_policy", as: :privacy_policy
  get "/terms-and-conditions", 
      to: "site#terms_and_conditions", as: :terms_and_conditions
  get "/my-feeds", to: "feeds#index", as: :my_feeds
end
