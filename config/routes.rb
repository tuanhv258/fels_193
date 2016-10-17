Rails.application.routes.draw do
  root "static_pages#home"
  get "/home", to: "static_pages#home"
  get "/help", to: "static_pages#help"
  get "/about", to: "static_pages#about"
  get "/contact", to: "static_pages#contact"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  post "/signup", to: "users#create"
  resources :users do
    member do
      get :following, :followers
    end
  end
  namespace :admin do
    resources :users, only: [:index]
  end
  resources :categories
  resources :words, only: :index
  resources :relationships
  resources :lessons
end
