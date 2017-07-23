Rails.application.routes.draw do
  resources :groups
  root 'welcome#index'
  get '/welcome', to: 'welcome#welcome'

  get '/signup', to: 'users#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
  get '/console', to: 'sessions#console'
  get '/debug', to: 'sessions#debug'
  post '/AddUserToGroup', to: 'groups#AddUserToGroup'
  post '/DeleteUserFromGroup', to: 'groups#DeleteUserFromGroup'
  resources :users
  resources :meals
  resources :ratings
  resources :metrics, only: :index
  get '/calendar/', to: 'meals#calendar'
end
