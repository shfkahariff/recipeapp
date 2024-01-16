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
  get '/admin_dashboard', to: 'home#admin_dashboard', as: 'admin_dashboard'
  
  devise_for :users, controllers: { 
    registrations: 'users/registrations', 
    sessions: 'users/sessions'  
  }
  resources :users, only: [:index, :destroy, :show]
  delete "users/:id", to: "users#destroy"
  post "users", to: "users#create"
  post '/users/:id/make_hr', to: 'users#make_hr', as: 'make_hr'
  post '/users/:id/make_admin', to: 'users#make_admin', as: 'make_admin'

  put '/leaves/:id/cancel', to: 'leaves#cancel', as: 'cancel'

  resources :leaves do
    member do
      post :approve
      post :decline
    end
  end
  
end
