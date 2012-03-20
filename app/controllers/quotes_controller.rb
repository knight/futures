class QuotesController < ApplicationController
  def index
    if not params[:from].nil?
      where_clause = "dtyyyymmdd >= :from"
      if not params[:to].nil?
        where_clause += " and dtyyyymmdd <= :to"
      end
    end
    if params[:to].nil? and params[:from].nil?
      @quotes = Quote.all
    else
      @quotes = Quote.where(where_clause, params)
    end
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
  
  def show
    
  end
  def edit
    @quote = Quote.find(params[:id])
    render :new
  end
  def new
    @quote = Quote.new
  end
  
  def upload
    
  end
  
  def import
    unless params[:quotes].blank?
      #Quote.import!("FW20,19991222,2050,2079,2049,2074,2084,4547")
      data = params[:quotes].read
      data.each do |line|
        Quote.import!(line.strip)
      end
      #File.new(params[:quotes].tempfile).readlines do |line|
      ##params[:quotes].read(params[:quotes].tempfile).readlines do |line|
      #  Quote.import!(line.strip)
      #end
      redirect_to :upload_quotes
    else
      render :upload
    end
  end
  def destroy
    Quote.destroy(params[:id])
    redirect_to :quotes
  end
end
