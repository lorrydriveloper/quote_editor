# frozen_string_literal: true

class QuotesController < ApplicationController
  before_action :set_quote, except: %i[index new create]

  def index
    @quotes = current_company.quotes.ordered
  end

  def show
    @line_item_dates = @quote.line_item_dates.includes(:line_items).ordered
  end

  def new
    @quote = Quote.new
  end

  def edit; end

  def create
    @quote = current_company.quotes.build(quotes_params)
    if @quote.save
      respond_to do |format|
        format.html {  redirect_to quotes_path, notice: "Quote #{t('created')}" }
        format.turbo_stream { flash.now[:notice] = "Quote #{t('created')}" }
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @quote.update(quotes_params)
      respond_to do |format|
        format.html {  redirect_to quotes_path, notice: "Quote #{t('updated')}" }
        format.turbo_stream { flash.now[:info] = "Quote #{t('updated')}" }
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @quote.destroy
    respond_to do |format|
      format.html { redirect_to quotes_path, notice: "Quote #{t('destroyed')}" }
      format.turbo_stream { flash.now[:success] = "Quote #{t('destroyed')}" }
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
