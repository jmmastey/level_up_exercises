Rails.application.routes.draw do
  devise_for :users
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  resources :books do 
    collection do
      get "search", to: 'books#search'
      get "results", to: 'books#results'
      get "select_item/:owi", to: 'books#select_item'
      get "collection", to: 'books#user_collection'
      get "item/:oclc", to: 'books#detailed_book_info'
      get "add_rec_book/:oclc", to: 'books#add_rec_book'
    end
  end

  resources :comments do
    collection do
      post ":oclc", to: 'comments#add_comment'
      post "/delete/:comment_id", to: 'comments#delete_comment'
    end
  end

  resources :recommendations do
    collection do
      get "recommended_books", to: 'recommendations#recommended_books'
      get "recommended_book/:oclc", to: 'recommendations#detailed_rec_info'
    end
  end

  resources :users
  # You can have the root of your site routed with "root"
  root 'static_pages#index'

  #Some book routes
# get 'books/new/search', to: 'books#get_search_query'
# get 'books/new/perform_search', to: 'books#perform_search'
# get 'books/new/select_item/:owi', to: 'books#select_item'
# get 'books/collection', to: 'books#user_collection'

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
