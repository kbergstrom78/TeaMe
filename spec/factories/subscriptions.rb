FactoryBot.define do
  factory :subscription do
    title { ["Monthly", "Yearly"].sample + " " + Faker::Tea.variety + " Box" }
    price { Faker::Commerce.price(range: 10..30.0) }
    status { ["active", "cancelled"].sample }
    frequency { ["monthly", "yearly"].sample }
    customer
  end
end
