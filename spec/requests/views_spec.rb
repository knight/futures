require 'spec_helper'
describe "Futures views" do
  it "should render form when visiting new action" do
    visit '/futures/new'
    page.should have_selector 'form'
  end
end
