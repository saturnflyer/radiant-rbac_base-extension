require File.dirname(__FILE__) + '/../../spec_helper'

describe Admin::RolesController, 'routing' do
  describe "route generation" do
    it "should map #new" do
      route_for(:controller => "admin/roles", :action => "new").should == "/admin/roles/new"
    end
    it "should map #show" do
      route_for(:controller => "admin/roles", :action => "show", :id => "1").should == "/admin/roles/1"
    end
    it "should map #edit" do
      route_for(:controller => "admin/roles", :action => "edit", :id => "1").should == "/admin/roles/1/edit"
    end
    it "should map #update" do
      route_for(:controller => "admin/roles", :action => "update", :id => "1").should == "/admin/roles/1"
    end
    it "should map #index" do
      route_for(:controller => "admin/roles", :action => "index").should == '/admin/roles'
    end
    it "should map #create" do
      route_for(:controller => "admin/roles", :action => "create").should == '/admin/roles'
    end
    it "should map #destroy" do
      route_for(:controller => "admin/roles", :action => "destroy", :id => "1").should == '/admin/roles/1'
    end
    it "should map #users" do
      route_for(:controller => "admin/roles", :action => "users", :role_id => "1").should == '/admin/roles/1/users'
    end
    it "should map #add_user" do
      route_for(:controller => "admin/roles", :action => "add_user", :role_id => "1", :id => "2").should == '/admin/roles/1/users/2'
    end
    it "should map #remove_user" do
      route_for(:controller => "admin/roles", :action => "remove_user", :role_id => "1", :id => "2").should == '/admin/roles/1/users/2'
    end
  end
  
  describe "route recognition" do
    it "should generate params for #new" do
      params_from(:get, "/admin/roles/new").should == {:controller => "admin/roles", :action => "new"}
    end
    it "should generate params for #create" do
      params_from(:post, "/admin/roles").should == {:controller => "admin/roles", :action => "create"}
    end
    it "should generate params for #show" do
      params_from(:get, "/admin/roles/1").should == {:controller => "admin/roles", :action => "show", :id => "1"}
    end
    it "should generate params for #update" do
      params_from(:get, "/admin/roles/1/edit").should == {:controller => "admin/roles", :action => "edit", :id => "1"}
    end
    it "should generate params for #update" do
      params_from(:put, "/admin/roles/1").should == {:controller => "admin/roles", :action => "update", :id => "1"}
    end
    it "should generate params for #destroy" do
      params_from(:delete, "/admin/roles/1").should == {:controller => "admin/roles", :action => "destroy", :id => "1"}
    end
    it "should generate params for #index" do
      params_from(:get, "/admin/roles").should == {:controller => 'admin/roles', :action => 'index'}
    end
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