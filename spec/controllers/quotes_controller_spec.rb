require 'spec_helper'

describe QuotesController do
  render_views
  def examplary_valid_quote_data
    { :quote=>{
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
    { :quote=>{
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
      assigns(:quotes).should eq(Quote.all)
    end
  end 
  
  describe "new action" do
    it "should resolve" do
      get :new
      response.should be_successful
    end
    
    it "should assign a blueprint object for the view to manipulate" do
      get :new
      assigns(:quote).should be_an(Quote)
    end
  end
  
  describe "create action" do
    it "should create a new entry in the model's table" do
      post :create, examplary_valid_quote_data
      Quote.all.count.should == 1
    end
    it "should redirect to index action if it is successful" do
      post :create, examplary_valid_quote_data
      response.should redirect_to(:quotes)
    end
    it "should render back new action if posted data is invalid" do
      post :create, examplary_invalid_quote_data
      response.should render_template(:new)
      response.body.should have_selector('form')
    end
    it "should not create any new objects in the database if posted data is invalid" do
      post :create, examplary_invalid_quote_data
      Quote.all.count.should == 0
    end
  end
end
