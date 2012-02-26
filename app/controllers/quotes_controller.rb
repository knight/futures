class QuotesController < ApplicationController
  def index
    @quotes = Quote.all
  end
  
  def create
    @quote = Quote.new(params[:quote])
    
    #respond_to do |format|
      if @quote.save
        redirect_to :quotes
      else
        render :new
      end
    #end

  end
  def new
    @quote = Quote.new
  end
end
