Rails.application.routes.draw do
  get "auth/:provider/callback", to: "sessions#create"

  root "home#index"
end
