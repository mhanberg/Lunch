class Meal < ApplicationRecord
  belongs_to :group
  enum category: [ :None, :Breakfast, :Lunch, :Dinner ]
end
