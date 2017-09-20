Rails.application.routes.draw do
  root 'welcome#index'
  get '/welcome', to: 'welcome#welcome'

  resources :groups
  post '/add_user_to_group', to: 'groups#add_user_to_group'
  post '/delete_user_from_group', to: 'groups#delete_user_from_group'

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
  get '/line_chart', to: 'metrics#line_chart'
end
