# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
SubscriptionTea.destroy_all
Subscription.destroy_all
Tea.destroy_all
Customer.destroy_all

10.times do
  FactoryBot.create(:customer)
end

5.times do
  FactoryBot.create(:tea)
end

Customer.all.each do |customer|
  subscription = FactoryBot.create(:subscription, customer: customer)
  subscription.teas << Tea.order(Arel.sql('RANDOM()')).limit(Faker::Number.between(from: 1, to: 3))
end