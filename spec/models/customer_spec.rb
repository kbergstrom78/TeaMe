require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe "relationships" do
    it { should have_many(:subscriptions) }
    it { should have_many(:teas).through(:subscriptions)}

    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email).case_insensitive }
    it { should allow_value("user@example.com").for(:email) }
    it { should validate_presence_of(:address) }
  end
end
