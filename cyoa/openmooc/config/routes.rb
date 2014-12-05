Rails.application.routes.draw do
  devise_for :users
  resources :courses, shallow: true, except: [:delete] do
    member do
      get 'edit_lessons'
    end
  end

  resources :lessons do
    member do
      put 'move_higher', as: 'move_higher'
      patch 'move_higher'
      put 'move_lower', as: 'move_lower'
      patch 'move_lower'
      get 'edit_pages'
    end
  end

  resources :pages do
    member do
      put 'move_higher', as: 'move_higher'
      patch 'move_higher'
      put 'move_lower', as: 'move_lower'
      patch 'move_lower'
    end
  end

  resources :contents

  resources :multiple_choice_questions do
    member do
      post :submit_answer
    end
  end

  resources :fill_in_the_blank_questions do
    member do
      get 'find_aliases'
      post 'build_answers'
      post 'submit_answer'
    end
  end

  resources :aliases do
  end

  get 'search/course', to: 'query#course'
  get 'help', to: 'application#help'
  get 'about', to: 'application#about'
  get 'feedback', to: 'feedback#new'
  post 'feedback', to: 'feedback#create'
  root to: 'application#index'
end
