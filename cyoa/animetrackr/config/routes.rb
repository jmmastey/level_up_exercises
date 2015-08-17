Rails.application.routes.draw do
  get 'friends/search'
  post 'friends/search', to: 'friends#search_redirect'
  get 'friends/search/:username' => 'friends#search'
  post 'friends/request/:id' => 'friends#send_request', as: 'friend_request'
  post 'friends/accept/:id' => 'friends#accept', as: 'friend_request_accept'
  post 'friends/reject/:id' => 'friends#reject', as: 'friend_request_reject'

  get 'anime_library/' => 'anime_library#index'
  get 'anime_library/:username', to: 'anime_library#view', as: 'anime_library_view'
  get 'anime_library/add/:id', to: 'anime_library#add', as: 'anime_library_add'
  post 'anime_library/add/:id', to: 'anime_library#create'
  get 'anime_library/edit/:id', to: 'anime_library#edit', as: 'anime_library_edit'
  patch 'anime_library/edit/:id', to: 'anime_library#submit_edit'
  delete 'anime_library/remove/:id', to: 'anime_library#remove', as: 'anime_library_remove'

  get 'anime/search'
  post 'anime/search' => 'anime#search_redirect'
  get 'anime/search/:title' => 'anime#search'
  get 'anime/edit'
  get 'anime/add/:id', to: 'anime#add', as: 'anime_add'
  post 'anime/add/:id', to: 'anime#add'
  get 'anime/remove'

  get 'profile/:username', to: 'profile#view', as: 'profile_view'
  get 'profile/' => 'profile#index'

  devise_for :users
  root to: 'root#home'

  # Set up or alter routes for test environment only
  if Rails.env.test?
    # Convert sign out from DELETE to GET for test environment only
    as :user do
      get 'users/sign_out' => 'devise/sessions#destroy'
    end
  end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
