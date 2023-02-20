# frozen_string_literal: true

class QuotesController < ApplicationController
  before_action :set_quote, except: %i[index new create]

  def index
    @quotes = current_company.quotes.ordered
  end

  def show; end

  def new
    @quote = Quote.new
  end

  def edit; end

  def create
    @quote = current_company.quotes.build(quotes_params)
    if @quote.save
      respond_to do |format|
        format.html {  redirect_to quotes_path, notice: 'Quote successfully created' }
        format.turbo_stream
      end

    else
      render :new
    end
  end

  def update
    if @quote.update(quotes_params)
      redirect_to quotes_path, notice: 'Quote successfully created'
    else
      render :edit
    end
  end

  def destroy
    @quote.destroy
    respond_to do |format|
      format.html { redirect_to quotes_path, notice: 'Quote was successfully destroyed.' }
      format.turbo_stream
    end
  end

  private

  def set_quote
    @quote = current_company.quotes.find(params[:id])
  end

  def quotes_params
    params.require(:quote).permit(:name)
  end
end
