FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { 'teste@email.com' }
    password { '123456' }
  end
end