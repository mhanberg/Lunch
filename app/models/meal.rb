class Meal < ApplicationRecord
  belongs_to :group
  has_many :ratings
  enum category: [ :None, :Breakfast, :Lunch, :Dinner ]

  def Meal.convert_to_calendar_json(meals)
    meals_json = []
    meals.each do |meal|
      meal = meal.as_json

      meal["title"] = meal["name"]
      if meal["category"] == "Breakfast"
        meal["start"] = meal["meal_date"].to_s + " 06:00:00"
      elsif meal["category"] == "Lunch"
        meal["start"] = meal["meal_date"].to_s + " 11:00:00"
      else
        meal["start"] = meal["meal_date"].to_s + " 17:30:00"
      end
      meals_json << meal
    end
    @meals_json = meals_json
  end
  
end
