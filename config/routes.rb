Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get '/customers', to: 'customers#index', as: :customers
      post '/customers/:customer_id/teas/:tea_id/subscribe', to: 'subscriptions#create', as: :subscribe_to_tea
      delete '/customers/:customer_id/subscriptions/:id', to: 'subscriptions#destroy', as: :subscription
    end
  end
end
