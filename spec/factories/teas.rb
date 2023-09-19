# frozen_string_literal: true

FactoryBot.define do
  factory :tea do
    title { Faker::Tea.variety }
    description { Faker::Tea.type }
    temperature { "#{Faker::Number.between(from: 150, to: 212)} F" }
    brew_time { "#{Faker::Number.between(from: 1, to: 5)} minutes" }
  end
end
