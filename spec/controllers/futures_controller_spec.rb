require 'spec_helper'

describe FuturesController do
  render_views
  def examplary_valid_quote_data
    { :future=>{
        :ticker=>"FW20",
        :dyyyymmdd=>"20120224",
        :open=>"2325",
        :high=>"2335",
        :low=>"2311",
        :close=>"2323"
      }
    }
  end
  def examplary_invalid_quote_data
    { :future=>{
        :ticker=>"FW20"
      }
    }
  end
  describe "index action" do
    it "should resolve" do
      get :index
      response.should be_successful
    end
    
    it "should assign Futures quotes for the view to manipulate" do
      get :index
      assigns(:futures).should eq(Future.all)
    end
  end 
  
  describe "new action" do
    it "should resolve" do
      get :new
      response.should be_successful
    end
    
    it "should assign a blueprint object for the view to manipulate" do
      get :new
      assigns(:future).should be_an(Future)
    end
  end
  
  describe "create action" do
    it "should create a new entry in the model's table" do
      post :create, examplary_valid_quote_data
      Future.all.count.should == 1
    end
    it "should redirect to index action if it is successful" do
      post :create, examplary_valid_quote_data
      response.should redirect_to(:futures)
    end
    it "should render back new action if posted data is invalid" do
      post :create, examplary_invalid_quote_data
      response.should render_template(:new)
      response.body.should have_selector('form')
    end
    it "should not create any new objects in the database if posted data is invalid" do
      post :create, examplary_invalid_quote_data
      Future.all.count.should == 0
    end
  end
end
