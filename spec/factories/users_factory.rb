FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "default#{n}@example.com" }
    first_name "Defaulty"
    last_name "Defaultson"
    password "password"
  end
end
