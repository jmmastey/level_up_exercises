Rails.application.routes.draw do
  devise_for :users
  resources :courses, except: [ :delete ] do
    member do
      get 'edit_sections'
      patch 'add_section'
      put 'add_section'
    end
  end

  resources :sections, only: [ :show, :destroy, :edit, :update ] do
    member do
      get 'edit_pages'
      resources :lesson_activities, only: [ :new, :create ]
      resources :quiz_activities, only: [ :new, :create ] do
        get :fill_in_the_blank_question, on: :new
        get :multiple_choice_question, on: :new
      end
    end
  end

  resources :pages, only: [ :show ] do
    member do
      put 'move_higher', as: 'move_higher'
      patch 'move_higher'
      put 'move_lower', as: 'move_lower'
      patch 'move_lower'
    end
  end

  resources :lesson_activities, only: [ :edit, :update]
  resources :quiz_activities, only: [ :edit, :update ] do
    get :update_fill_in_the_blank_question, on: :member
    get :update_multiple_choice_question, on: :member
  end

  resources :multiple_choice_questions, only: [ :update ] do
    collection do
      post :create_for_section
      post :update_for_quiz_activity
    end
    member do
      post :submit_answer
    end
  end

  resources :fill_in_the_blank_questions, only: [ :update ] do
    collection do
      post :create_for_section
      post :update_for_quiz_activity
    end
    member do
      post :submit_answer
    end
  end

  resources :fill_in_the_blank_questions, only: [] do
    member do
      get 'find_aliases'
      post 'create_answers'
    end
  end

  resources :aliases, only: [] do
    collection do
    end
  end

  get 'search/course', to: 'query#course'
  get 'help', to: 'application#help'
  get 'about', to: 'application#about'
  get 'feedback', to: 'feedback#new'
  post 'feedback', to: 'feedback#create'
  root to: 'application#index'
end
