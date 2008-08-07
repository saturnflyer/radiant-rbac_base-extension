class CreateRoleUsers < ActiveRecord::Migration
  def self.up
    create_table :roles_users, :id => false do |t|
      t.column :role_id, :integer, :null => false
      t.column :user_id, :integer, :null => false
    end
    add_index :roles_users, :role_id
    add_index :roles_users, :user_id
  end

  def self.down
    drop_table :roles_users
    remove_index :roles_users, :role_id
    remove_index :roles_users, :user_id
  end
end
