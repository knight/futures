require 'spec_helper'

describe QuotesController do
  include ActionDispatch::TestProcess
  render_views
  def examplary_valid_quote_data
    { :quote=>{
        :ticker=>"FW20",
        :dtyyyymmdd=>"20120224",
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
  
  describe "upload action" do
    it "should resolve" do
      get :upload
      response.should be_successful
    end
    
    it "should have an upload form with upload button and upload field" do
      get :upload
      response.body.should have_selector('form')
      response.body.should have_selector('input[type=file]')
      response.body.should have_selector('input[type=submit]')
    end
  end
  
  describe "import action" do
    it "should have a test file with many lines" do
      File.should exist("#{Rails.root}/spec/fixtures/FW20-few.mst")
      File.new("#{Rails.root}/spec/fixtures/FW20-few.mst").readlines.count.should > 0
    end
    
    it "should import uploaded file to quotes table" do
      post :import, {:quotes=>fixture_file_upload('/FW20-few.mst')}
      Quote.all.count.should > 0
    end
    it "should redirect back to upload if successful upload is performed" do
      post :import, {:quotes=>fixture_file_upload('/FW20-few.mst')}
      response.should redirect_to(:upload_quotes)
    end
    it "should render upload form when no file is uploaded" do
      post :import, {}
      response.should render_template(:upload)
    end
  end
end
