require 'spec_helper'

describe "Futures views" do
  describe "new action" do
    it "should render form when visiting new action" do
      visit '/futures/new'
      page.should have_selector 'form'
    end
  end
  
  describe "index action" do
    it "should render a table with futures quotes" do
      visit '/futures/'
      page.should have_selector 'table'
    end
    it "should render a link to new action" do
      visit '/'
      page.should have_selector 'a[href="/futures/new"]'
    end
  end
end
