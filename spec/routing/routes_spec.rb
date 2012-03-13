require 'spec_helper'


describe "routing" do
  it "routes by default to Quotes controller" do
    { :get => '/'}.should route_to(
      :controller => "quotes",
      :action => "index"
    )
  end
  
  it "routes /quotes/upload to QuotesController#upload" do
    { :get => '/quotes/upload'}.should route_to :controller=>"quotes", :action=>"upload"
  end
  
  it "routes /quotes/import to QuotesController#import" do
    { :post=> '/quotes/import'}.should route_to :controller=>"quotes", :action=>"import"
  end
  
  it "routes /quotes/index/20120101 to QuotesController#index" do
    { :get => '/quotes/index/20120101' }.should route_to :controller=>"quotes", :action=>"index", :from=>"20120101"
  end
  
  it "routes /quotes/index/20120101/20120102 to QuotesController#index" do
    { :get => '/quotes/index/20120101/20120102'}.should route_to ({:controller=>"quotes", :action=>"index", :from=>"20120101", :to=>"20120102"})
  end
end
