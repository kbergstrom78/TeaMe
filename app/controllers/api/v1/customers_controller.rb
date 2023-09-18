class Api::V1::CustomersController < ApplicationController
  # before_action :set_customer, only: %i[ show update destroy ]

  # GET /customers
  def index
    @customers = Customer.all

    render json: CustomerSerializer.new(Customer.all)
  end

  # GET /customers/1
  def show
    render json: @customer
  end

  private

    def customer_params
      params.require(:customer).permit(:first_name, :last_name, :email, :address)
    end
end
