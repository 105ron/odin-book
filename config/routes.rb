Rails.application.routes.draw do
  root to: "users#index"
  devise_for :users, :controllers =>{ :omniauth_callbacks => "omniauth_callbacks",
  																		:registrations => 'registrations' }
  resources :users, only: [:index]
  resources :posts, only: [:index]
  resources :friendships, only: [:create, :update, :destroy]
  resources :likes, only: [:create, :destroy]
end
