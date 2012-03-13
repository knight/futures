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
  validates_presence_of :ticker, :dtyyyymmdd, :open, :high, :low, :close
  validates_uniqueness_of :dtyyyymmdd
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
    Quote.set_from_array(self, values)
  end
  
  def height
    (open - close).abs
  end
  
  def Quote.import!(line)
    q = Quote.import(line)
    unless q.nil?
      q.save
    end
  end
  
  def Quote.import(line)
    if line.scan(/\<\w+\>/).length > 0
      return
    end
    values = line.split(",")
    quote = Quote.find_by_dtyyyymmdd(values[1])
    unless (quote.nil?)
      Quote.set_from_array(quote, values)
    else
      quote = Quote.new
      quote.import(line)
    end
    quote
  end
  
  def Quote.set_from_array(quote, values)
      quote.ticker= values[0]
      quote.dtyyyymmdd= values[1]
      quote.open= values[2]
      quote.high= values[3]
      quote.low= values[4]
      quote.close= values[5]
      quote.vol= values[6]
      quote.openint= values[7]
      quote
  end
  
end
