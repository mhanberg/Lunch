class RemoveDefaultGroupForeignKeyFromUsersTable < ActiveRecord::Migration[5.0]
  def change
    remove_foreign_key :users, column: :default_group_id
  end
end
