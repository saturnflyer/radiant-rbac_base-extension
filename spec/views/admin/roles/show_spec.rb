require File.dirname(__FILE__) + '/../../../spec_helper'

describe 'show' do
  let(:role){mock_model(Role,:role_name => 'Test', :description => 'The test role.', :allow_empty => true)}
  before do
    template.should_receive(:include_stylesheet).with('rbac/rbac')
    template.stub!(:include_javascript)
    assigns[:role] = role
  end
  it "should display the role name" do
    render 'admin/roles/show'
    response.should have_tag('h1',/Test/)
  end
end