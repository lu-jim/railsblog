FactoryBot.define do
  factory :users do
    name { Faker::Lorem.name }
    created_by { Faker::Number.number(10) }
  end
end
