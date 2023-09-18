Rails.application.routes.draw do
  resources :subscriptions
  resources :customers
  resources :teas
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
