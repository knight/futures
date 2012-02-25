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
  
  it "should have new action" do
    get :new
    response.code.should eq "200"
  end
  
  it "should assign a blueprint in the new action" do
    get :new
    assigns(:future).should be_an(Future)
  end
  
  it "should redirect back to new action if the data are invalid" do
    post :create, {}
    response.should redirect_to(:new_future)
    Future.all.count.should == 0 
  end
  
  it "should redirect back to index action if the creation is successful" do
    post :create, { :future=>{
      :ticker=>"FW20",
      :dyyyymmdd=>"20120224",
      :open=>"2325",
      :high=>"2335",
      :low=>"2311",
      :close=>"2323"
    }}
    response.should redirect_to(:futures)
    Future.all.count.should == 1
  end
end
