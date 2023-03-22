# frozen_string_literal: true

class LineItemDatesController < ApplicationController
  before_action :set_quote
  before_action :set_line_item_date, only: %i[edit update destroy]

  def new
    @line_item_date = @quote.line_item_dates.build
  end

  def edit; end

  def create
    @line_item_date = @quote.line_item_dates.build(line_item_date_params)

    if @line_item_date.save
      respond_to do |format|
        format.html {  redirect_to quote_path(@quote), notice: "Date #{t('created')}" }
        format.turbo_stream { flash.now[:notice] = "Date #{t('created')}" }
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @line_item_date.update(line_item_date_params)
      respond_to do |format|
        format.html { redirect_to @quote, notice: "Date #{t('updated')}" }
        format.turbo_stream { flash.now[:notice] = "Date #{t('updated')}" }
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @line_item_date.destroy
    respond_to do |format|
      format.html { redirect_to line_item_dates_path, notice: "Date #{t('destroyed')}" }
      format.turbo_stream { flash.now[:success] = "Date #{t('destroyed')}" }
    end
  end

  private

  def line_item_date_params
    params.require(:line_item_date).permit(:date)
  end

  def set_quote
    @quote = current_company.quotes.find(params[:quote_id])
  end

  def set_line_item_date
    @line_item_date = @quote.line_item_dates.find(params[:id])
  end
end
