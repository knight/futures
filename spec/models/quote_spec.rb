require 'spec_helper'

describe Quote do
  before do
    #"FW20",20120210,2372,2376,2344,2346,37728,129068
    @quote = Quote.create!(:ticker=>"FW20", :dyyyymmdd=>20120210, :open=>2372, :high=>2376, :low=>2344, :close=>2346, :vol=>37728, :openint=>37728)
  end

  it "we should have one record when we create and save an entry" do
    #created in before
    Quote.all.count.should == 1
  end
  it "should not save if mandatory attiributes are missing" do
    quote = Quote.create(:ticker=>"FW20")
    quote.should_not be_valid
  end
  
  it "should have unique dyyyymmdd attribute" do
     quote = Quote.create(:ticker=>"FW20", :dyyyymmdd=>20120210, :open=>2372, :high=>2376, :low=>2344, :close=>2346, :vol=>37728, :openint=>37728)
     quote.should_not be_valid
  end
  
  it "should have the other registrated prices lower than the highest price" do
    quote = Quote.create(:ticker=>"FW20", :dyyyymmdd=>20120213, :open=>2377, :high=>2376, :low=>2344, :close=>2346, :vol=>37728, :openint=>37728)
    quote.should_not be_valid
  end
  
  it "should have the other registrated prices higher than the highest price" do
    quote = Quote.create(:ticker=>"FW20", :dyyyymmdd=>20120213, :open=>2372, :high=>2376, :low=>2347, :close=>2346, :vol=>37728, :openint=>37728)
    quote.should_not be_valid
  end
  
  it "should tell whether the quote forms a dark candle" do
    quote = Quote.create(:ticker=>"FW20", :dyyyymmdd=>20120211, :open=>2372, :high=>2376, :low=>2344, :close=>2346, :vol=>37728, :openint=>37728)
    quote.should be_dark
  end
  
  it "should tell whether the quote forms a white candle" do
    quote = Quote.create(:ticker=>"FW20", :dyyyymmdd=>20120211, :open=>2345, :high=>2376, :low=>2344, :close=>2370, :vol=>37728, :openint=>37728)
    quote.should be_white
  end
  
  it "should not be white when it's dark" do
    quote = Quote.create!(:ticker=>"FW20", :dyyyymmdd=>20120211, :open=>2372, :high=>2376, :low=>2344, :close=>2346, :vol=>37728, :openint=>37728)
    quote.should_not be_white
  end
  
  it "should not be dark when it's white" do
    quote = Quote.create!(:ticker=>"FW20", :dyyyymmdd=>20120211, :open=>2344, :high=>2376, :low=>2344, :close=>2372, :vol=>37728, :openint=>37728)
    quote.should_not be_dark
  end
  
  it "should be able to compute its higher shadow" do
    @quote.higher_shadow.should == 4
  end
  
  it "should be able to compute its lower shadow" do
    @quote.lower_shadow.should == 2
  end
  
  it "should be able to compute shadows for white candles too" do
    quote = Quote.create!(:ticker=>"FW20", :dyyyymmdd=>20120213, :open=>2300, :high=>2376, :low=>2299, :close=>2360, :vol=>37728, :openint=>37728)
    quote.lower_shadow.should == 1
    quote.higher_shadow.should == 16
  end
  
  it "can import a coma separated line feed" do
    quote = Quote.new
    quote.import("FW20,20000103,2261,2274,2234,2244,4074,4955")
    
    quote.ticker.should == "FW20"
    quote.dyyyymmdd.should == 20000103
    quote.open.should == 2261
    quote.high.should == 2274
    quote.low.should == 2234
    quote.close == 2244
    quote.vol == 4074
    quote.openint == 4955
  end
  
  it "can skip schema line" do
    quote = Quote.new
    quote.import("<TICKER>,<DTYYYYMMDD>,<OPEN>,<HIGH>,<LOW>,<CLOSE>,<VOL>,<OPENINT>")
    quote.ticker.should be_nil
  end
  
  it "can create a Quote instance from a line feed" do
    quote = Quote.import("FW20,20000103,2261,2274,2234,2244,4074,4955")
    quote.ticker.should == "FW20"
  end
  
  it "can create a Quote instance from a line feed and save" do
    Quote.import!("FW20,20000103,2261,2274,2234,2244,4074,4955")
    Quote.all.count == 2
  end

end
