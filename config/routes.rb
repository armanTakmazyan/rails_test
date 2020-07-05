Rails.application.routes.draw do
  root to: 'application#index'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy' 

  resources :employees
  resources :companies
  #resources :users
  
end
