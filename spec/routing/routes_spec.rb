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
end
