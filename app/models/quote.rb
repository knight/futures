class QuotesValidator < ActiveModel::Validator
  def validate(record)
    if not record.high.nil? and ([record.open, record.low, record.close].take_while { |p| not p.nil? }.max > record.high)
      record.errors[:high] << "The high price is not the actual highest price"
    end
    if not record.low.nil? and ([record.open, record.high, record.close].take_while {|p| not p.nil? }.min < record.low)
      record.errors[:low] << "The low price is not the actual lowest price"
    end
  end
end


class Quote < ActiveRecord::Base
  validates_presence_of :ticker, :dyyyymmdd, :open, :high, :low, :close
  validates_uniqueness_of :dyyyymmdd
  validates_with QuotesValidator
  
  def dark?
    close - open < 0
  end
  
  def white?
    open - close < 0
  end
  
  def higher_shadow
    if close > open
      high - close
    else
      high - open
    end
  end
  
  def lower_shadow
    if close > open
      open - low
    else
      close - low
    end
  end
  
  def import(line)
    if line.scan(/\<\w+\>/).length > 0
      return
    end
    values = line.split(",")
    self.ticker= values[0]
    self.dyyyymmdd= values[1]
    self.open= values[2]
    self.high= values[3]
    self.low= values[4]
    self.close= values[5]
    self.vol= values[6]
    self.openint= values[7]
  end
  
  def Quote.import!(line)
    q = Quote.import(line)
    q.save
  end
  
  def Quote.import(line)
    quote = Quote.new
    quote.import(line)
    quote
  end
  
end
