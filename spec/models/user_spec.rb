require File.dirname(__FILE__) + '/../spec_helper'

describe User do
  describe "roles" do
    it "should return an array of roles" do
      User.new.roles.should == []
    end
  end
end