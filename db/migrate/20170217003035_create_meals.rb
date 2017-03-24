class CreateMeals < ActiveRecord::Migration[5.0]
  def change
    create_table :meals do |t|
      t.text :name
      t.text :description
      t.integer :type
      t.integer :group_id, null: false

      t.timestamps
    end
  end
end
