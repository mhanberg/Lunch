class ChangeColumnTypeToCategory < ActiveRecord::Migration[5.0]
  def change
    rename_column :meals, :type, :category
  end
end
