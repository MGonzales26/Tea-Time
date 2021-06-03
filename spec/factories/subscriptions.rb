FactoryBot.define do
  factory :subscription do
    title { "economy" }
    price { 9.99 }
    status { "active" }
    frequency { "monthly" }
  end
end
