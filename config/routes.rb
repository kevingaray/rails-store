Rails.application.routes.draw do
  root 'items#index'
  devise_for :users
  resources :items do
    resources :likes, only: [:create, :destroy]
    resources :comments, module: :items
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

  resources :orders, :only => [:show, :index, :new] do
    resources :comments, module: :orders
  end

  
  namespace :admin do
    resources :items_change_logs, only: [:index]
  end
  
end
