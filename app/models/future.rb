class Future < ActiveRecord::Base
  validates_presence_of :ticker, :dyyyymmdd, :open, :high, :low, :close
  validates_uniqueness_of :dyyyymmdd
end
