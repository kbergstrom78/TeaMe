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
      post api_v1_customer_subscriptions_path(customer_id: customer.id, tea_id: tea.id), headers: headers, params: JSON.generate(subscription_params)
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

  describe "DELETE /destroy" do
    let(:customer) { FactoryBot.create(:customer) }
    let(:tea) { FactoryBot.create(:tea) }
    let(:subscription_params) {
      attributes = FactoryBot.attributes_for(:subscription).except(:tea_id)  # Remove the tea_id attribute
      attributes.merge({customer_id: customer.id})
    }
    let(:subscription) {
      sub = Subscription.new(subscription_params)
      sub.customer = customer
      sub.teas << tea
      sub.save!
      sub
    }

    it 'deletes a subscription and returns successful response' do
      subscription
      # require 'pry'; binding.pry
      expect {
        delete api_v1_customer_subscription_path(customer_id: subscription.customer_id, id: subscription.id)
      }.to change(Subscription, :count).by(-1)

      expect(response).to be_successful
      expect(Subscription.find_by(id: subscription.id)).to be_nil
    end
  end

  describe "GET /index" do
    let(:customer) { FactoryBot.create(:customer) }
    let!(:subscriptions) { FactoryBot.create_list(:subscription, 5, customer: customer) }

    before do
      get api_v1_customer_subscriptions_path(customer_id: customer.id)
    end

    it 'returns all the customer subscriptions' do
      expect(response).to be_successful
      expect(JSON.parse(response.body)['data'].size).to eq(5)    end
  end


end
