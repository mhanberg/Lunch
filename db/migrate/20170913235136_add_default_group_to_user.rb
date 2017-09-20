class AddDefaultGroupToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :default_group_id, :integer
    add_foreign_key :users, :groups, column: :default_group_id
  end
end
