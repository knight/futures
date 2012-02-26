require 'spec_helper'


describe "routing" do
  it "routes by default to Quotes controller" do
    { :get => '/'}.should route_to(
      :controller => "quotes",
      :action => "index"
    )
  end
end
