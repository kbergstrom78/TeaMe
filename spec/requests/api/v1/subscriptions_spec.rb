require 'rails_helper'

RSpec.describe "/subscriptions", type: :request do
  describe "POST /create" do
    let(:customer) { FactoryBot.create(:customer) }
    let(:tea) { FactoryBot.create(:tea) }
    let(:subscription_params) {
      attributes = FactoryBot.attributes_for(:subscription)
      attributes.merge({customer_id: customer.id, tea_id: tea.id})
    }

    let(:headers) { { 'CONTENT_TYPE' => 'application/json' } }

    before do
      post api_v1_subscribe_to_tea_path(customer_id: customer.id, tea_id: tea.id), headers: headers, params: JSON.generate(subscription_params)
    end

    it 'creates a subscription and returns successful response' do
      new_subscription = Subscription.last

      expect(response).to be_successful
      expect(new_subscription.title).to eq(subscription_params[:title])
      expect(new_subscription.price).to eq(subscription_params[:price])
      expect(new_subscription.status).to eq(subscription_params[:status])
      expect(new_subscription.frequency).to eq(subscription_params[:frequency])
      expect(new_subscription.customer_id).to eq(customer.id)
    end
  end
end
