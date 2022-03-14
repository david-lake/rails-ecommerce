FactoryBot.define do
  factory :user do
    first_name { Faker::Lorem.characters(10) }
    last_name { Faker::Lorem.characters(10) }
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    activated { true }
    activated_at  { Time.zone.now }
  end
end
