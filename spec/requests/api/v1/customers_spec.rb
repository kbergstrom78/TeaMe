require 'rails_helper'
require 'factory_bot_rails'


RSpec.describe "/customers", type: :request do

  describe "GET /index" do
    it "renders a successful response" do
      get api_v1_customers_path
      customer_info = JSON.parse(response.body, symbolize_names: true)
      customer = customer_info[:data]

      customer.each do |customer|
        expect(customer[:data]).to have_key(:first_name)
        expect(customer[:data][:first_name]).to be_a(String)
        expect(customer[:data]).to have_key(:last_name)
        expect(customer[:data][:last_name]).to be_a(String)
        expect(customer[:data]).to have_key(:email)
        expect(customer[:data][:email]).to be_a(String)
        expect(customer[:data]).to have_key(:address)
        expect(customer[:data][:address]).to be_a(text)
      end
    end
  end
end
