require File.dirname(__FILE__) + '/../spec_helper'

describe Role do
  
  it "should err that role_name 'has already been taken' when saving without a unique name" do
    Role.new.save!
    lambda {
      Role.new.save!
    }.should raise_error(ActiveRecord::RecordInvalid, /has already been taken/)
  end
  
  it "should err when saved with a standard Radiant Role name" do
    lambda { Role.new(:role_name => 'admin').save! }.should raise_error(ActiveRecord::RecordInvalid,/may not be any of: admin, developer/)
  end
  
  describe 'users' do
    it "should return an array" do
      Role.new.users.should == []
    end
  end
  
end