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
  
  it "should have a description" do
    Role.new.respond_to?(:description).should be_true
  end
  it "should have an allow_empty field" do
    Role.new.respond_to?(:allow_empty).should be_true
  end
  
  describe 'remove_user' do
    before do
      @user = mock_model(User)
      @users = [@user]
      @users.stub!(:<<).and_return(true)
      @role = Role.create!(:role_name => 'Test')
      @role.stub!(:allow_empty).and_return(true)
      @role.stub!(:users).and_return(@users)
    end
    it "should delete the user from the role" do
      @role.users << @user
      @users.stub!(:size).and_return(2)
      @users.should_receive(:delete).with(@user).and_return(true)
      @role.remove_user(@user)
    end
    it "should return true" do
      @role.remove_user(@user).should be_true
    end
    describe "with 1 user and allow_empty set to false" do
      before do
        @users.should_receive(:size).and_return(1)
        @role.should_receive(:allow_empty).and_return(false)
      end
      it "should not delete the user from the role" do
        @users.should_not_receive(:delete)
        @role.remove_user(@user)
      end
      it "should return false" do
        @role.remove_user(@user).should_not be_true
      end
    end
  end
  
  describe 'users' do
    it "should return an array" do
      Role.new.users.should == []
    end
  end
  
  describe "standard?" do
    it "should return true if the role's downcased role_name is in the Radiant standard roles" do
      @role = Role.new(:role_name => 'admin')
      @role.standard?.should be_true
    end
  end
  
end