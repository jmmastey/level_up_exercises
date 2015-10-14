Rails.application.routes.draw do
  resources :characters, only: [:index, :show]
  resources :quests, only: [:show, :edit, :update]
  resources :categories, only: [:index, :show]
  resources :activities, only: [:show]

  devise_for :users

  root 'welcome#index'

  patch 'activities/add_to_goals/:id', to: 'activities#add_to_goals',
        as: :add_to_goals

  patch 'activities/remove_from_goals/:id', to: 'activities#remove_from_goals',
        as: :remove_from_goals

  patch 'activities/hide/:id', to: 'activities#hide', as: :hide_activity

  patch 'activities/unhide', to: 'activities#unhide', as: :unhide_activities
end
