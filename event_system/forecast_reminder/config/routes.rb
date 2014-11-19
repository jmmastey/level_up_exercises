Rails.application.routes.draw do
  devise_for :users, :controllers => {:registrations => "registrations"}
  get 'forecast/index'
  root 'forecast#index'
end
