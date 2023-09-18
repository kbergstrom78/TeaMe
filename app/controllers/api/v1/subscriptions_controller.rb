class Api::V1::SubscriptionsController < ApplicationController

  # POST /subscriptions
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


  # DELETE /subscriptions/1
  # def destroy
  #   @subscription.destroy
  # end

  private

    def subscription_params
      params.require(:subscription).permit(:title, :price, :status, :frequency)
    end
end
