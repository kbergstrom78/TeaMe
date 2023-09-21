# frozen_string_literal: true

module Api
  module V1
    module Customers
      class SubscriptionsController < ApplicationController
        before_action :set_customer
        before_action :set_subscription, only: [:update]

        def create
          tea = Tea.find_by_id(params[:tea_id])
          return render json: { error: 'Tea not found' }, status: :not_found unless tea

          subscription = @customer.subscriptions.new(subscription_params)

          if subscription.save
            subscription.teas << tea
            render json: { message: 'Subscription created successfully', subscription: }, status: :created
          else
            render json: { errors: subscription.errors.full_messages }, status: :unprocessable_entity
          end
        end

        def update
          if @subscription.nil?
            render json: { error: 'Subscription not found' }, status: :not_found
          elsif handle_status_update
            render json: { message: 'Status updated successfully' }, status: :ok
          else
            render json: { error: 'Unable to update status' }, status: :unprocessable_entity
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

        def set_subscription
          @subscription = @customer.subscriptions.find_by_id(params[:id])
        end

        def handle_status_update
          case subscription_params[:status]
          when 'cancelled'
            @subscription.cancel
          else
            false
          end
        end

        def subscription_params
          params.require(:subscription).permit(:title, :price, :status, :frequency)
        end
      end
    end
  end
end
