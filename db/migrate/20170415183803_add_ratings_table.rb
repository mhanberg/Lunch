class AddRatingsTable < ActiveRecord::Migration[5.0]
  def change
    create_table :ratings do |r|
      r.integer :meal_id
      r.integer :user_id
      r.integer :score
      r.text :comment
    end

    add_index :ratings, [:meal_id, :user_id], unique: true
  end
end
