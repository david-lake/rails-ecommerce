FactoryBot.define do
  factory :user do
    first_name { Faker::Lorem.characters(10) }
    last_name { Faker::Lorem.characters(10) }
    email { Faker::Lorem.characters(10) + "@example.com" }
    password { Faker::Lorem.characters(10) }
    activated { true }
    activated_at  { Time.zone.now }
  end
end
