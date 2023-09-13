Rails.application.routes.draw do 
  devise_for :users
  resources :groups, only: [:index, :new, :create] do
    resources :purchases, only: [:index, :new, :create]
  end

  get '/not_logged_in', to: 'users#not_logged_in'

  root 'groups#index'
  # Defines the root path route ("/")
  # root "articles#index"
end
