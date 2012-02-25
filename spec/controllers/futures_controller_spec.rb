require 'spec_helper'

describe FuturesController do
  it "should resolve index action" do
    get :index
    response.code.should eq("200")
  end
  
  it "should assign Futures" do
    get :index
    assigns(:futures).should eq(Future.all)
  end
end
