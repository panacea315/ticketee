
FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "test_#{n}@example.com" }
    password { "password" }

    trait :admin do
      admin { true }
    end
  end
end