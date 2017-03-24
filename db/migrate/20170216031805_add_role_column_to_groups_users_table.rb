class AddRoleColumnToGroupsUsersTable < ActiveRecord::Migration[5.0]
  def change
    add_column :groups_users, :role, :string
  end
end
