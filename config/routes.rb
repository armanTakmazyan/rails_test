Rails.application.routes.draw do
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'session#destroy' 

  resources :employees
  resources :companies
  #resources :users
  
end
