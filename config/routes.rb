Rails.application.routes.draw do
  get 'sessions/new'
  get 'users/new'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  get '/', to: 'application#index'
  post '/signup', to: 'users#create'
  get '/login', to: 'sessions#new'

  get '/find', to: 'sessions#find'

  post   '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  post   '/task', to: 'tasks#create'
  get '/tasks', to: 'tasks#index'
end
