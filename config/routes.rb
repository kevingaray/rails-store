Rails.application.routes.draw do
  root 'items#index'
  devise_for :users
  resources :items do
    resources :likes, only: [:create, :destroy]
    resources :comments, module: :items do
      post 'approved'
      delete 'delete'
    end
  end

  # carts routes
  get 'carts/:id' => 'carts#show', as: 'cart'
  delete 'carts/:id' => 'carts#destroy'

  # line_items routes
  post 'line_items/:id/add' => 'line_items#add_quantity', as: 'line_item_add'
  post 'line_items/:id/reduce' => 'line_items#reduce_quantity', as: 'line_item_reduce'
  post 'line_items' => 'line_items#create'
  get 'line_items/:id' => 'line_items#show', as: 'line_item'
  delete 'line_items/:id' => 'line_items#destroy'

    # stripe checkout sessions
    post 'checkout/create', to: 'checkout#create'
    get "success", to: "checkout#success"
    get "cancel", to: "checkout#cancel"
    resources :webhooks, only: [:create]


  resources :orders, :only => [:show, :index, :new, :create] do
    resources :comments, module: :orders
  end

  namespace :admin do
    resources :items_change_logs, only: [:index]
    require 'sidekiq/web'
    authenticate :user, -> (u) { u.admin } do
      mount Sidekiq::Web => '/sidekiq'
    end
  
  end

  namespace :api, defaults: { format: :json }  do
    namespace :v1 do

      resources :items do
        post 'likes' => 'likes#create'
        delete 'likes' => 'likes#destroy'
      end
      
      post "auth/login", to: "authentication#login"
      resources :users, only: [:index, :show, :create, :destroy] do
        post 'comments' => 'comments#create'
        delete 'comments/:comment_id' => 'comments#destroy'
        post '/comments/:comment_id/approve' => 'comments#approve'
      end

      resources :orders, only: [:index, :show, :create]

      get 'carts' => 'carts#show'
      delete 'carts' => 'carts#destroy' 
      
      post 'line_items' => 'line_items#create'
      delete 'line_items' => 'line_items#destroy'
      
    end
  end 
  
end
