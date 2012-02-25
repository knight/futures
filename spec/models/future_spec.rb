require 'spec_helper'

describe Future do
  before do
    #"FW20",20120210,2372,2376,2344,2346,37728,129068
    @future = Future.create!(:ticker=>"FW20", :dyyyymmdd=>20120210, :open=>2372, :high=>2376, :low=>2344, :close=>2346, :vol=>37728, :openint=>37728)
  end

  it "we should have one record when we create and save an entry" do
    #created in before
    Future.all.count.should == 1
  end
  it "should not save if mandatory attiributes are missing" do
    future = Future.create(:ticker=>"FW20")
    future.should_not be_valid
  end
  
  it "should have unique dyyyymmdd attribute" do
     future = Future.create(:ticker=>"FW20", :dyyyymmdd=>20120210, :open=>2372, :high=>2376, :low=>2344, :close=>2346, :vol=>37728, :openint=>37728)
     future.should_not be_valid
  end
  
  it "should have the other registrated prices lower than the highest price" do
    future = Future.create(:ticker=>"FW20", :dyyyymmdd=>20120213, :open=>2377, :high=>2376, :low=>2344, :close=>2346, :vol=>37728, :openint=>37728)
    future.should_not be_valid
  end
  
  it "should have the other registrated prices higher than the highest price" do
    future = Future.create(:ticker=>"FW20", :dyyyymmdd=>20120213, :open=>2372, :high=>2376, :low=>2347, :close=>2346, :vol=>37728, :openint=>37728)
    future.should_not be_valid
  end
  it "should tell whether the future forms a dark candle" do
    future = Future.create(:ticker=>"FW20", :dyyyymmdd=>20120211, :open=>2372, :high=>2376, :low=>2344, :close=>2346, :vol=>37728, :openint=>37728)
    future.is_dark?.should be_true
  end
  
  it "should tell whether the future forms a white candle" do
    future = future = Future.create(:ticker=>"FW20", :dyyyymmdd=>20120211, :open=>2345, :high=>2376, :low=>2344, :close=>2370, :vol=>37728, :openint=>37728)
    future.is_white?.should be_true
  end
  it "should not be white when it's dark" do
    future = Future.create!(:ticker=>"FW20", :dyyyymmdd=>20120211, :open=>2372, :high=>2376, :low=>2344, :close=>2346, :vol=>37728, :openint=>37728)
    future.is_white?.should be false
  end
  
  it "should not be dark when it's white" do
    future = Future.create!(:ticker=>"FW20", :dyyyymmdd=>20120211, :open=>2344, :high=>2376, :low=>2344, :close=>2372, :vol=>37728, :openint=>37728)
    future.is_dark?.should be false
  end
  
  it "should be able to compute its higher shadow" do
    @future.higher_shadow.should == 4
  end
  
  it "should be able to compute its lower shadow" do
    @future.lower_shadow.should == 2
  end
  
  it "should be able to compute shadows for white candles too" do
    future = Future.create!(:ticker=>"FW20", :dyyyymmdd=>20120213, :open=>2300, :high=>2376, :low=>2299, :close=>2360, :vol=>37728, :openint=>37728)
    future.lower_shadow.should == 1
    future.higher_shadow.should == 16
  end

end
