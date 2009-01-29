require File.dirname(__FILE__) + '/../../../spec_helper'

describe 'show' do
  before do
    template.should_receive(:include_stylesheet).with('rbac/rbac')
    template.stub!(:include_javascript)
    @role = mock_model(Role,:role_name => 'Test', :description => 'The test role.')
    assigns[:role] = @role
  end
  it "should display the role name" do
    render 'admin/roles/show'
    response.should have_tag('h1',/Test/)
  end
end