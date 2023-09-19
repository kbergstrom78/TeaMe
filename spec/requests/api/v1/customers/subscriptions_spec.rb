# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/subscriptions', type: :request do
  describe 'POST /create' do
    let(:customer) { FactoryBot.create(:customer) }
    let(:tea) { FactoryBot.create(:tea) }
    let(:subscription_params) do
      attributes = FactoryBot.attributes_for(:subscription)
      attributes.merge({ customer_id: customer.id, tea_id: tea.id })
    end

    let(:headers) { { 'CONTENT_TYPE' => 'application/json' } }

    before do
      post api_v1_customer_subscriptions_path(customer_id: customer.id, tea_id: tea.id), headers:,
                                                                                         params: JSON.generate(subscription_params)
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

  context 'when creating a subscription fails' do
    let(:customer) { FactoryBot.create(:customer) } # Define the customer variable
    let(:tea) { FactoryBot.create(:tea) }
    let(:invalid_subscription_params) do
      {
        subscription: {
          title: nil,
          price: 'twenty_dollars',
          status: 'active',
          frequency: 'monthly',
          customer_id: customer.id,
          tea_id: tea.id
        }
      }
    end

    let(:headers) { { 'CONTENT_TYPE' => 'application/json' } }

    it 'returns unprocessable_entity status with errors' do
      post api_v1_customer_subscriptions_path(customer_id: customer.id, tea_id: tea.id), headers:,
                                                                                         params: invalid_subscription_params.to_json
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe 'DELETE /destroy' do
    let(:customer) { FactoryBot.create(:customer) }
    let(:tea) { FactoryBot.create(:tea) }
    let(:subscription_params) do
      attributes = FactoryBot.attributes_for(:subscription).except(:tea_id) # Remove the tea_id attribute
      attributes.merge({ customer_id: customer.id })
    end
    let(:subscription) do
      Subscription.create!(
        customer:,
        title: subscription_params[:title],
        price: subscription_params[:price],
        status: subscription_params[:status],
        frequency: subscription_params[:frequency],
        teas: [tea]
      )
    end

    it 'deletes a subscription and returns successful response' do
      subscription

      expect do
        delete api_v1_customer_subscription_path(customer_id: subscription.customer_id, id: subscription.id)
      end.to change(Subscription, :count).by(-1)

      expect(response).to be_successful
      expect(Subscription.find_by(id: subscription.id)).to be_nil
    end

    context 'when deleting a subscription fails' do
      before do
        allow_any_instance_of(Subscription).to receive(:destroy).and_return(false)
        delete api_v1_customer_subscription_path(customer_id: customer.id, id: subscription.id)
      end

      it 'returns unprocessable_entity status with error message' do
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)).to have_key('error')
      end
    end
  end

  describe 'GET /index' do
    let(:customer) { FactoryBot.create(:customer) }
    let!(:subscriptions) { FactoryBot.create_list(:subscription, 5, customer:) }

    before do
      get api_v1_customer_subscriptions_path(customer_id: customer.id)
    end

    it 'returns all the customer subscriptions' do
      expect(response).to be_successful
      expect(JSON.parse(response.body)['data'].size).to eq(5)
    end
  end
end
