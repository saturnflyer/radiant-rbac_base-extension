class CreateRoles < ActiveRecord::Migration
  def self.up
    create_table :roles do |t|
      t.column :role_name, :string, :limit => 64, :default => "New Role"
    end
  end

  def self.down
    drop_table :roles
  end
end
