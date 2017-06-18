class AddPrimaryKeyToGroupsUserTable < ActiveRecord::Migration[5.0]
  def change
    add_column :groups_users, :id, :primary_key
  end
end
