Rails.application.routes.draw do
  resource :session

  resources :employees
  resources :companies
  resources :users
  
end
