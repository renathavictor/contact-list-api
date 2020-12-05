FactoryBot.define do
  factory :list do
    title { Faker::Lorem.word }
    created_by { Faker::Number.number(10) }
  end
end