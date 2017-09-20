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

  resources :users, only: [:new, :create]
  post '/default_group', to: 'users#default_group'

  resources :meals
  get '/calendar', to: 'meals#calendar'
  resources :ratings

  get '/response_pie', to: 'metrics#response_pie'
  get '/meal_type_histogram', to: 'metrics#meal_type_histogram'
end
