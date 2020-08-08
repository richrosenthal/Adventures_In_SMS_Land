Rails.application.routes.draw do

  get '/' => 'sessions#welcome'
  post '/' => 'sessions#create'

  resources :users


  resources :sessions
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
