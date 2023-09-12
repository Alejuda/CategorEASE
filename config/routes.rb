Rails.application.routes.draw do
  resources :groups
  resources :purchases
  resources :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root 'groups#index'
  # Defines the root path route ("/")
  # root "articles#index"
end
