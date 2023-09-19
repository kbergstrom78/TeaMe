# frozen_string_literal: true

FactoryBot.define do
  factory :subscription do
    title { "#{%w[Monthly Yearly].sample} #{Faker::Tea.variety} Box" }
    price { Faker::Commerce.price(range: 10..30.0) }
    status { %w[active cancelled].sample }
    frequency { %w[monthly yearly].sample }
    customer
  end
end
