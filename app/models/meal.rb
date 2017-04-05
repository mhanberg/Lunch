class Meal < ApplicationRecord
  belongs_to :group
  enum category: [ :None, :Breakfast, :Lunch, :Dinner ]

  def Meal.convert_to_calendar_json(meals)
    meals_json = []
    meals.each do |meal|
      meal = meal.as_json

      meal["title"] = meal["name"]
      if meal["category"] = 2
        meal["start"] = meal["meal_date"].to_s + " 11:00:00"
      else
        meal["start"] = meal["meal_date"].to_s + " 05:30:00"
      end
      meals_json << meal
    end
    @meals_json = meals_json
  end
  
end
