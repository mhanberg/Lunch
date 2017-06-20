FactoryGirl.define do
  factory :rating do
    comment "Default comment"
    score 1
    
    meal
    user
  end
end
