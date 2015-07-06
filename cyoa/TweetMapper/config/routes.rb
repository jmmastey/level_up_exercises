Rails.application.routes.draw do
  root 'home#index'

  post 'tweets/latest',
    to: 'tweets#latest',
    constraints: { format: '' }
end
