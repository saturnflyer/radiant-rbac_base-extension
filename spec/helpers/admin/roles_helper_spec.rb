require File.dirname(__FILE__) + '/../../spec_helper'

describe Admin::RolesHelper do
  describe "named routes" do
    it "should write admin_role_user_path to '/admin/roles/:role_id/users/:id'" do
      admin_role_user_path('1','2').should == '/admin/roles/1/users/2'
    end
    it "should write admin_role_users_path to '/admin/roles/:role_id/users'" do
      admin_role_users_path('1').should == '/admin/roles/1/users'
    end
  end
end