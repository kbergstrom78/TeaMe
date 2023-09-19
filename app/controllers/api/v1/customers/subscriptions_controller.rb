module Api::V1::Customers
  class SubscriptionsController < ApplicationController

    before_action :set_customer

    def create
      tea = Tea.find(params[:tea_id])
      @subscription = @customer.subscriptions.new(subscription_params)
      @subscription.teas << tea

      if @subscription.save
        render json: @subscription, status: :created
      else
        render json: @subscription.errors, status: :unprocessable_entity
      end
    end

    def destroy
      @subscription = @customer.subscriptions.find_by_id(params[:id])
      if @subscription&.destroy
        render json: { message: 'Subscription deleted successfully' }, status: :ok
      else
        render json: { error: 'Failed to delete subscription' }, status: :unprocessable_entity
      end
    end

    private

      def set_customer
        @customer = Customer.find(params[:customer_id])
      end

      def subscription_params
        params.require(:subscription).permit(:title, :price, :status, :frequency)
      end
  end
end