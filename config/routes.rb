Rails.application.routes.draw do
  root 'welcome#index'
  get '/welcome', to: 'welcome#welcome'

  resources :groups
  post '/AddUserToGroup', to: 'groups#AddUserToGroup'
  post '/DeleteUserFromGroup', to: 'groups#DeleteUserFromGroup'

  get '/signup', to: 'users#new'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
  get '/console', to: 'sessions#console'
  get '/debug', to: 'sessions#debug'


  resources :users
  resources :meals
  get '/calendar', to: 'meals#calendar'
  resources :ratings
  resources :metrics, only: :index
end
