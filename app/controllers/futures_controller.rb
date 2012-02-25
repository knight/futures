class FuturesController < ApplicationController
  def index
    @futures = Future.all
  end
end
