Rails.application.routes.draw do
  resources :groups
  root 'welcome#index'

  get '/signup', to: 'users#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  post '/AddUserToGroup', to: 'groups#AddUserToGroup'
  post '/DeleteUserFromGroup', to: 'groups#DeleteUserFromGroup'
  resources :users
  resources :meals
  resources :ratings
  get '/calendar/', to: 'meals#calendar'
end
