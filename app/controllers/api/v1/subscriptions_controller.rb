class Api::V1::SubscriptionsController < ApplicationController

  def create
    customer = Customer.find(params[:customer_id])
    tea = Tea.find(params[:tea_id])

    @subscription = Subscription.new(subscription_params)
    @subscription.customer = customer
    @subscription.teas << tea

    if @subscription.save
      render json: @subscription, status: :created
    else
      render json: @subscription.errors, status: :unprocessable_entity
    end
  end


  def destroy
    @subscription = Subscription.find_by_id(params[:id])
    if @subscription.destroy
      render json: { message: 'Subscription deleted successfully' }, status: :ok
    else
      render json: { error: 'Failed to delete subscription' }, status: :unprocessable_entity
    end
  end

  private

    def subscription_params
      params.require(:subscription).permit(:title, :price, :status, :frequency)
    end
  end
