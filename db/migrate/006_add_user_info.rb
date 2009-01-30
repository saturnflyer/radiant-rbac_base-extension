class AddUserInfo < ActiveRecord::Migration
  def self.up
    add_column :roles, :created_by_id, :integer
    add_column :roles, :updated_by_id, :integer
  end
  def self.down
    remove_column :roles, :updated_by_id
    remove_column :roles, :created_by_id    
  end
end