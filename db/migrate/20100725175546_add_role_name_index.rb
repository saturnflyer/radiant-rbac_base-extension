class AddRoleNameIndex < ActiveRecord::Migration
  def self.up
    add_index :roles, :role_name
  end

  def self.down
    remove_index :roles, :column => :role_name
  end
end
