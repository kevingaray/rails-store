Rails.application.routes.draw do
  root 'items#index'
  devise_for :users
  resources :items do
    resources :likes, only: [:create, :destroy]
  end
end
