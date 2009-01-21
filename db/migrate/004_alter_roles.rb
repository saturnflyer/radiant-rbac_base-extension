class AlterRoles < ActiveRecord::Migration
  def self.up
    add_column :roles, :description, :string
    add_column :roles, :allow_empty, :boolean, :default => true
  end
  def self.down
    remove_column :roles, :allow_empty
    remove_column :roles, :description
  end
end