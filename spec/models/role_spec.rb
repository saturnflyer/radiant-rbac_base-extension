require File.dirname(__FILE__) + '/../spec_helper'

describe Role do
  
  it "should err that role_name 'has already been taken' when saving without a unique name" do
    Role.new.save!
    lambda {
      Role.new.save!
    }.should raise_error(ActiveRecord::RecordInvalid, /has already been taken/)
  end
  
  it "should not err when saved with a standard Radiant Role name" do
    lambda { Role.new(:role_name => 'admin').save! }.should_not raise_error(ActiveRecord::RecordInvalid,/may not be any of: admin, developer/)
  end
  
  describe 'Role::RADIANT_STANDARDS' do
    it "should be an array of 'admin' and 'developer'" do
      Role::RADIANT_STANDARDS.should == ['admin','developer']
    end
  end
  
  it "should err when destroying a Radiant standard role" do
    Role::RADIANT_STANDARDS.each do |role|
      Role.create!(:role_name => role)
      lambda { Role.find_by_role_name(role).destroy }.should raise_error(Role::ProtectedRoleError, /is a protected role and may not be removed/)
    end
  end
  
  describe 'users' do
    it "should return an array" do
      Role.new.users.should == []
    end
  end
  
end