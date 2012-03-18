require "spec_helper"
describe "quotes/index" do
  context "no quotes data" do
    before (:each) do
      assign(:quotes, [])
    end
    
    it "should display title" do
      
      render
      rendered.should have_selector("h1")
      rendered.should =~ /Quotes/
    end
    
    it "should have a table with quotes" do
      render
      rendered.should have_selector("table")
    end
    
    it "should have a link to new action" do
      render
      rendered.should have_selector('a[href="/quotes/new"]')
    end
  end
end
