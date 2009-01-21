class AlterRoles < ActiveRecord::Migration
  def self.up
    add_column :roles, :description, :string
    add_column :roles, :allow_empty, :boolean, :default => true
    
    Role.find_by_role_name('Admin').update_attributes({:allow_empty => false,
      :description => %{Users in the Admin role, by default, have access to all features of the system.}})
    Role.find_by_role_name('Developer').update_attributes({
      :description => %{Users in the Admin role, by default, have access to all features of the system.}})
  end
  def self.down
    remove_column :roles, :allow_empty
    remove_column :roles, :description
  end
end