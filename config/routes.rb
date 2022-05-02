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
  get '/task/:id', to: 'tasks#show'
  patch '/task/:id', to: 'tasks#update'
  delete '/task/:id', to: 'tasks#destroy'
  get '/tasks', to: 'tasks#index'

  put 'task/start', to: 'tasks#start'
  put 'task/stop', to: 'tasks#stop'

  post '/range', to: 'ranges#create'
  get 'range/:id', to: 'ranges#show'
  patch '/range/:id', to: 'ranges#update'
  delete '/range/:id', to: 'ranges#destroy'
  get '/ranges', to: 'ranges#index'

  # post '/task', to: 'tasks#create'
  # get '/tasks', to: 'tasks#index'
end
