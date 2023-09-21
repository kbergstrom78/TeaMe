module Api
  module V1
    module Customers
      class SubscriptionsController < ApplicationController
        before_action :set_customer

        def create
          tea = Tea.find_by_id(params[:tea_id])
          return render json: { error: 'Tea not found' }, status: :not_found unless tea

          subscription = @customer.subscriptions.new(subscription_params)

          if subscription.save
            subscription.teas << tea
            render json: { message: 'Subscription created successfully', subscription: subscription }, status: :created
          else
            render json: { errors: subscription.errors.full_messages }, status: :unprocessable_entity
          end
        end

        def update
          @subscription = @customer.subscriptions.find_by_id(params[:id])
          return render json: { error: 'Subscription not found' }, status: :not_found unless @subscription

          if subscription_params[:status] == 'cancelled'
            handle_cancel_subscription and return
          else
            render json: { error: 'Invalid status update' }, status: :unprocessable_entity and return
          end
        end
        
        def index
          subscriptions = @customer.subscriptions
          render json: SubscriptionSerializer.new(subscriptions).serializable_hash.to_json
        end

        private

        def set_customer
          @customer = Customer.find(params[:customer_id])
        end

        def handle_cancel_subscription
          if @subscription.cancel
            render json: { message: 'Subscription cancelled successfully' }, status: :ok
          else
            render json: { error: 'Unable to cancel subscription' }, status: :unprocessable_entity
          end
        end

        def subscription_params
          params.require(:subscription).permit(:title, :price, :status, :frequency)
        end
      end
    end
  end
end
