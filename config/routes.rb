# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :customers do
        scope module: 'customers' do
          resources :subscriptions, only: %i[create update index]
        end
      end
    end
  end
end
