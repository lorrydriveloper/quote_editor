# frozen_string_literal: true

require 'application_system_test_case'

class LineItemsTest < ApplicationSystemTestCase
  setup do
    login_as users(:accountant)
    @quote = quotes(:second)
  end

  test 'Create a New Line Item' do
    visit quote_path(@quote)
    create_new_item(DateTime.current)
    assert_selector 'h1', text: @quote.name
    assert_text I18n.l(@quote.line_item_dates.last.date, format: :long)
  end

  test 'Add new item after prev date' do
    visit quote_path(@quote)
    create_new_item(DateTime.current)
    create_new_item(DateTime.current + 1.day)

    assert_selector 'h1', text: @quote.name
    prev_date = @quote.line_item_dates.last.prev_date
    element = page.find("#line_item_date_#{prev_date.to_param}")
    element.assert_sibling("#line_item_date_#{@quote.line_item_dates.last.to_param}")
  end

  test 'Add new item before prev date' do
    visit quote_path(@quote)
    create_new_item(DateTime.current + 1.day)
    create_new_item(DateTime.current)
    create_new_item(DateTime.current + 2.days)

    assert_selector 'h1', text: @quote.name
    target_el = @quote.line_item_dates.where(date: DateTime.current + 1.day).first
    element = page.find("#line_item_date_#{target_el.to_param}")
    element.assert_sibling("#line_item_date_#{target_el.next_date.to_param}")
  end

  private

  def create_new_item(date)
    click_on 'New Date'
    fill_in 'line_item_date_date', with: date

    assert_selector 'h1', text: @quote.name
    click_on 'Create Line item date'
  end
end
