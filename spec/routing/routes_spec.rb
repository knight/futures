require 'spec_helper'


describe "routing" do
  it "routes by default to Futures controller" do
    { :get => '/'}.should route_to(
      :controller => "futures",
      :action => "index"
    )
  end
end
