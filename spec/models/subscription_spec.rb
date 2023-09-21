# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Subscription, type: :model do
  describe 'relationships' do
    it { should belong_to(:customer) }
    it { should have_many(:teas).through(:subscription_teas) }
  end

  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:price) }
    it { should validate_presence_of(:status) }
    it { should validate_inclusion_of(:status).in_array(%w[active cancelled]) }
    it { should validate_presence_of(:frequency) }
    it { should validate_presence_of(:customer_id) }
  end

  describe '#cancel?' do
  let(:subscription) { FactoryBot.create(:subscription, status: status) }

    context 'when status is cancelled' do
      let(:status) { 'cancelled' }

      it 'returns true' do
        expect(subscription.active?).to be(false)
      end
    end

    context 'when status is not cancelled' do
      let(:status) { 'active' }

      it 'returns false' do
        expect(subscription.active?).to be(true)
      end
    end
  end

  describe '#remove_subscription_teas' do
    let(:subscription) { FactoryBot.create(:subscription) }
    let(:tea) { FactoryBot.create(:tea) }

    before do
      subscription.teas << tea
    end

    it 'clears the teas from the subscription upon destroy' do
      subscription.destroy
      expect(subscription.teas.reload).to be_empty
    end
  end
end

