Rails.application.routes.draw do
  root "pages#home"
  get "about", to: "pages#about"
  resources :articles  # Can be used like this also -->  resources :articles, only: [:show, :update, :destroy]
  get "signup", to: "users#new"
  resources :users, except: [:new]
  # Authentication
  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"
end
