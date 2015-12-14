Rails.application.routes.draw do
  get 'welcome/index'
  root 'welcome#index'
  devise_for :users, controllers: { omniauth_callbacks: "callbacks" }

  devise_scope :user do
    get 'sign_in', to: 'devise/sessions#new', as: :new_user_session
    get 'sign_out', to: 'devise/sessions#destroy', as: :destroy_user_session
  end

  namespace :api do
    namespace :v1 do
      resources :bills
    end
  end
end
