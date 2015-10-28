Rails.application.routes.draw do
  get "auth/delivery/authorize",
    to: "delivery_auth#authorize",
    as: :delivery_auth_authorize

  get "auth/delivery/callback",
    to: "delivery_auth#callback",
    as: :delivery_auth_callback

  resource :session, only: [:new, :destroy]

  root "home#index"
end
