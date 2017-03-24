class AddDateColumnToMealsTable < ActiveRecord::Migration[5.0]
  def change
    add_column :meals, :meal_date, :date
  end
end
