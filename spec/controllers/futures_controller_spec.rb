require 'spec_helper'

describe FuturesController do
  render_views
  it "should resolve index action" do
    get :index
    response.should be_successful
  end
  
  it "should assign Futures quotes for index view" do
    get :index
    assigns(:futures).should eq(Future.all)
  end
  
  it "should resolve new action" do
    get :new
    response.should be_successful
  end
  
  it "should assign a blueprint in the new action" do
    get :new
    assigns(:future).should be_an(Future)
  end
  
  it "should render back new action if create data are invalid" do
    post :create, {}
    response.should render_template(:new)
    response.body.should have_selector('form')
    Future.all.count.should == 0 
  end
  
  it "should redirect to index action if the creation is successful" do
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
