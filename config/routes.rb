Rails.application.routes.draw do
  root "pages#home"
  get "about", to: "pages#about"
  resources :articles  # Can be used like this also -->  resources :articles, only: [:show, :update, :destroy]
end
