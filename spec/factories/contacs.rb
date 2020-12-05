FactoryBot.define do
  factory :contact do
    name { Faker::TvShows::Friends.character }
    email { Faker::Internet.email }
    phone { Faker::PhoneNumber.cell_phone }
    list_id nil
  end
end
