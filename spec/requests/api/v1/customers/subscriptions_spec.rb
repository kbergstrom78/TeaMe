# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Customer Subscriptions API', type: :request do
  let(:customer) { FactoryBot.create(:customer) }
  let(:headers) { { 'CONTENT_TYPE' => 'application/json' } }

  describe 'POST /create' do
    let(:tea) { FactoryBot.create(:tea) }
    let(:subscription_params) do
      {
        title: 'Chamomile Tea',
        price: 20.0,
        status: 'active',
        frequency: 'monthly'
      }
    end

    before do
      post "/api/v1/customers/#{customer.id}/subscriptions?tea_id=#{tea.id}",
           headers:,
           params: JSON.generate({ subscription: subscription_params })
    end

    it 'creates a subscription and returns successful response' do
      new_subscription = Subscription.last

      expect(response).to be_successful
      expect(new_subscription.title).to eq(subscription_params[:title])
      expect(new_subscription.price).to eq(subscription_params[:price])
      expect(new_subscription.status).to eq('active')
      expect(new_subscription.frequency).to eq(subscription_params[:frequency])
      expect(new_subscription.customer_id).to eq(customer.id)
    end
  end

  context 'when creating a subscription fails' do
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

    it 'returns unprocessable_entity status with errors' do
      post api_v1_customer_subscriptions_path(customer_id: customer.id, tea_id: tea.id), headers:,
                                                                                         params: JSON.generate(invalid_subscription_params)
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe 'PATCH /update' do
    let(:active_subscription) { FactoryBot.create(:subscription, status: 'active', customer:) }

    it 'cancels an active subscription and returns successful response' do
      patch api_v1_customer_subscription_path(customer_id: active_subscription.customer_id, id: active_subscription.id),
            params: { subscription: { status: 'cancelled' } }

      expect(response).to be_successful
      active_subscription.reload
      expect(active_subscription.status).to eq('cancelled')
    end
  end

  context 'when canceling a subscription fails' do
    let(:subscription) { FactoryBot.create(:subscription, customer:, status: 'active') }
    let(:update_params) { { subscription: { status: 'cancelled' } } }

    before do
      allow_any_instance_of(Subscription).to receive(:update).and_return(false)
      patch api_v1_customer_subscription_path(customer_id: customer.id, id: subscription.id), headers:,
                                                                                              params: JSON.generate(update_params)
    end

    it 'returns unprocessable_entity status with error message' do
      expect(response).to have_http_status(:unprocessable_entity)
      expect(JSON.parse(response.body)).to have_key('error')
    end
  end

  context 'when updating subscription with invalid status' do
    let(:subscription) { FactoryBot.create(:subscription, customer:, status: 'active') }
    let(:invalid_params) do
      {
        subscription: {
          status: 'invalid_status'
        }
      }
    end

    it 'returns 422 Unprocessable Entity' do
      patch api_v1_customer_subscription_path(customer_id: customer.id, id: subscription.id), headers:,
                                                                                              params: JSON.generate(invalid_params)
      expect(response).to have_http_status(:unprocessable_entity)
      expect(JSON.parse(response.body)['error']).to eq('Invalid status update')
    end
  end

  describe 'GET /index' do
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
