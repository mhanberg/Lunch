class ChangeRoleColumnTypeForGroupsUsers < ActiveRecord::Migration[5.0]
  def change
    change_column :groups_users, :role, 'integer USING CAST(role AS integer)'
  end
end
