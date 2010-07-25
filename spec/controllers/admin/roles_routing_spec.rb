require File.dirname(__FILE__) + '/../../spec_helper'

describe Admin::RolesController, 'routing' do
  describe "route generation" do
    it "should map #users" do
      '/admin/roles/1/users'.should route_to(:controller => "admin/roles", :action => "users", :role_id => "1")
    end
    it "should map #add_user" do
      {:post => '/admin/roles/1/users/2'}.should route_to(:controller => "admin/roles", :action => "add_user", :role_id => "1", :id => "2")
    end
    it "should map #remove_user" do
      { :delete => '/admin/roles/1/users/2'}.should route_to(:controller => "admin/roles", :action => "remove_user", :role_id => "1", :id => "2")
    end
  end
  
  describe "route recognition" do
    it "should generate params for #add_user" do
      params_from(:post, "/admin/roles/1/users/2").should == {:controller => 'admin/roles', :action => 'add_user', :role_id => '1', :id => '2'}
    end
    it "should generate params for #remove_user" do
      params_from(:delete, "/admin/roles/1/users/2").should == {:controller => 'admin/roles', :action => 'remove_user', :role_id => '1', :id => '2'}
    end
    it "should generate params for #users" do
      params_from(:get, "/admin/roles/1/users").should == {:controller => 'admin/roles', :action => 'users', :role_id => '1'}
    end
  end
end