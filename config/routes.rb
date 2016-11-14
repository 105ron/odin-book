Rails.application.routes.draw do
  root to: "users#index"
  devise_for :users, :controllers =>{ :omniauth_callbacks => "omniauth_callbacks",
  																		:registrations => 'registrations' }
  resources :users, only: [:index]
end
