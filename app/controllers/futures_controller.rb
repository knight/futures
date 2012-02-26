class FuturesController < ApplicationController
  def index
    @futures = Future.all
  end
  
  def create
    @future = Future.new(params[:future])
    
    #respond_to do |format|
      if @future.save
        redirect_to :futures
      else
        render :new
      end
    #end

  end
  def new
    @future = Future.new
  end
end
