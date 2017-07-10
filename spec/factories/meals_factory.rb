FactoryGirl.define do
  factory :meal do
    name 'Default Meal Name'
    description 'Default description'
    meal_date 3.days.from_now
    category 1

    group
  end
end
