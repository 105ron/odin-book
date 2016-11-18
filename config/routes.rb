Rails.application.routes.draw do
  root to: "users#index"
  devise_for :users, :controllers =>{ :omniauth_callbacks => "omniauth_callbacks",
  																		:registrations => 'registrations' }
  resources :users, only: [:index, :show]
  resources :posts, only: [:index, :create]
  resources :friendships, only: [:create, :update, :destroy]
  resources :likes, only: [:create, :destroy]
  resources :posts, only: [:create]
  resources :comments, only: [:create]
end
