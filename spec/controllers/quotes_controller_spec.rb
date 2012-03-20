require 'spec_helper'

describe QuotesController do
  include ActionDispatch::TestProcess
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
  
  def import_fixture
    f = File.new("#{Rails.root}/spec/fixtures/FW20-few.mst")
    Quote.delete(:all)
    f.each_line do |line|
      Quote.import! line.strip
    end
  end
  describe "index action" do
    let(:quote) { 
      stub_model(Quote)
    }
    it "should resolve" do
      get :index
      response.should be_successful
    end
    it "should assign Futures quotes for the view to manipulate" do
      
      Quote.stub(:all).and_return([])
      
      get :index
      assigns(:quotes).should eq(Quote.all)
    end
    
    context "in filtering context" do
      let(:quote) { mock_model(Quote) }
      before(:each) { import_fixture }
      
      it "can limit quotes objects by :from date" do
        get :index, :from=>"19991227"
        assigns(:quotes).count.should eq(3)
      end
      
      it "can limit quotes by :from and :to dates" do
        get :index, :from=>"19991227", :to=>"19991227"
        assigns(:quotes).count.should eq(1)
      end
      
      it "should send query with :from and :to filtering attributes" do
        Quote.should_receive(:where).with(
          "dtyyyymmdd >= :from and dtyyyymmdd <= :to",
          hash_including(:from=>"19991227", :to=>"19991227")
        )
        get :index, :from=>"19991227", :to=>"19991227"
      end
      
      it "should send query with a :from filtering attribute" do
        Quote.should_receive(:where).with(
          "dtyyyymmdd >= :from",
          hash_including(:from=>"19991227")
        )
        get :index, :from=>"19991227"
      end
      
    end
  end 
  
  describe "new action" do
    let(:quote) { mock_model(Quote).as_new_record }
    it "should resolve" do
      get :new
      response.should be_successful
    end
    
    it "should assign a blueprint object for the view to manipulate" do
      Quote.should_receive(:new).and_return(quote)
      get :new
      assigns(:quote).should be_a(Quote)
      assigns(:quote).should be_new_record
    end
  end
  
  describe "show action" do
    it "should resolve" do
      get :show, :id=>1
      response.should be_successful
    end
  end
  describe "edit action" do
    let(:quote) { mock_model(Quote, {:id=>1}) }
    before (:each) do
      Quote.should_receive(:find).and_return(quote)
    end
    
    it "should resolve" do
      get :edit, :id=>1
      response.should be_successful
    end
    
    it "should make a quote object available for the view" do
      
      get :edit, :id=>1
      assigns[:quote].should be_a(Quote)
      assigns[:quote].id.should eq(1)
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
  describe "destroy action" do
    let(:quote) { mock_model(Quote) }
    it "should call destroy on Quote model" do
      Quote.should_receive(:destroy).with("1")
      delete :destroy, :id=>1
      
    end
    it "should redirect to index" do
      Quote.should_receive(:destroy)
      delete :destroy, {:id=>1}
      response.should be_redirect
    end
  end
end
