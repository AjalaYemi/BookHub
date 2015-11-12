Rails.application.routes.draw do

  devise_for :users

  authenticated :user do
    root to: 'public#show', as: :authenticated_root
  end

  devise_scope :user do
    get 'users/sign_out' => 'devise/sessions#destroy'
  end
  root to: 'public#index'

  resources :books do
    member do
      resources :comments, :only => [:create, :destroy]
      get :delete
    end
  end

  get 'tags/:tag', to: 'books#index', as: :tag

  resources :events do
    member do
      resources :comments, :only => [:create, :destroy]
      get :delete
    end
  end

  resources :reviews do
    member do
      resources :comments, :only => [:create, :destroy]
      get :delete
    end
  end

  match '/contact_us', to: 'contacts#new', via: 'get'
  resources "contacts", only: [:new, :create]
  get 'search', to: 'search#search'

  # resources :public do
  #   member do
  #     get :contact
  #   end
  # end

  # resources :book_exchanges do
  #   collection do
  #     get :swap
  #   end

  #   collection do
  #     get :donate
  #   end
  # end
  #
  devise_scope :user do
    get 'users/sign_out' => 'devise/sessions#destroy'
  end

  match ':controller(/:action(/:id(.:format)))', :via => [:get, :post]

  #  get "books_controller/index"
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
