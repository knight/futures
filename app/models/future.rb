class FuturesValidator < ActiveModel::Validator
  def validate(record)
    if not record.high.nil? and ([record.open, record.low, record.close].take_while { |p| not p.nil? }.max > record.high)
      record.errors[:high] << "The high price is not the actual highest price"
    end
    if not record.low.nil? and ([record.open, record.high, record.close].take_while {|p| not p.nil? }.min < record.low)
      record.errors[:low] << "The low price is not the actual lowest price"
    end
  end
end


class Future < ActiveRecord::Base
  validates_presence_of :ticker, :dyyyymmdd, :open, :high, :low, :close
  validates_uniqueness_of :dyyyymmdd
  validates_with FuturesValidator
  
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
end
