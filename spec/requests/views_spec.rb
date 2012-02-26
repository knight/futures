require 'spec_helper'

describe "Quotes views" do
  describe "new action" do
    #render_views
    it "should render form when visiting new action" do
      visit '/quotes/new'
      page.should have_selector 'form'
    end
    it "should render form with sent data when create action is unsuccessful" do
      post '/quotes', {:quote=>{:ticker=>"FW20"}}
      response.body.should have_selector('form input', {:name=>"ticker",:value=>"FW20"})
    end
  end
  
  describe "index action" do
    it "should render a table with futures quotes" do
      visit '/quotes/'
      page.should have_selector 'table'
    end
    it "should render a link to new action" do
      visit '/'
      page.should have_selector 'a[href="/quotes/new"]'
    end
  end
end

