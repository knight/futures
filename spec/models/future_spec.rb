require 'spec_helper'

describe Future do
  it "should have no records when created" do
    Future.all.should be_empty
  end
  it "we should have one record when we create and save an entry" do
    #"FW20",20120210,2372,2376,2344,2346,37728,129068
    Future.create!(:ticker=>"FW20", :dyyyymmdd=>20120210, :open=>2372, :high=>2376, :low=>2344, :close=>2346, :vol=>37728, :openint=>37728)
    Future.all.count.should == 1
  end
  it "should not save if mandatory attiributes are missing" do
    future = Future.create(:ticker=>"FW20")
    future.should_not be_valid
  end
  
  it "should have unique dyyyymmdd attribute" do
     Future.create!(:ticker=>"FW20", :dyyyymmdd=>20120210, :open=>2372, :high=>2376, :low=>2344, :close=>2346, :vol=>37728, :openint=>37728)
     future = Future.create(:ticker=>"FW20", :dyyyymmdd=>20120210, :open=>2372, :high=>2376, :low=>2344, :close=>2346, :vol=>37728, :openint=>37728)
     future.should_not be_valid
  end
end
