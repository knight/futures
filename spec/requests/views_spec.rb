require 'spec_helper'

describe "Futures views" do
  describe "new action" do
    #render_views
    it "should render form when visiting new action" do
      visit '/futures/new'
      page.should have_selector 'form'
    end
    it "should render form with sent data when create action is unsuccessful" do
      post '/futures', {:future=>{:ticker=>"FW20"}}
      response.body.should have_selector('form input', {:name=>"ticker",:value=>"FW20"})
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

