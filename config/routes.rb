Rails.application.routes.draw do
  get 'users/index'
  resources :leaves
  resources :leave_balances
  #devise_for :users
  resources :holidays
  root 'home#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  get 'home/profile'
  get 'users/index'

  devise_for :users, controllers: { 
    registrations: 'users/registrations', 
    sessions: 'users/sessions'  
  }
  resources :users, only: [:index, :destroy, :show]
  delete "users/:id", to: "users#destroy"
  post "users", to: "users#create"
  
end
