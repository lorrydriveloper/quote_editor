# frozen_string_literal: true

require 'application_system_test_case'

class CrudLineItemDatesTest < ApplicationSystemTestCase
  setup do
    login_as users(:accountant)
    @quote = quotes(:second)

    visit quote_path(@quote)
  end

  test 'Create a New Line Item Date' do
    create_new_item_date(DateTime.current)
    assert_selector 'h1', text: @quote.name
    assert_text I18n.l(@quote.line_item_dates.last.date, format: :long)
  end

  test 'Updating a Line Item Date' do
    create_new_item_date(DateTime.current)
    assert_selector 'h1', text: @quote.name
    assert_text I18n.l(@quote.line_item_dates.last.date, format: :long)
    target = @quote.line_item_dates.first

    within id: dom_id(target) do
      click_on 'Edit'
    end
    assert_selector 'h1', text: @quote.name

    fill_in 'Date', with: Date.current + 1.day
    click_on 'Update Line item date'

    assert_text I18n.l(Date.current + 1.day, format: :long)
  end

  test 'Destroy a Line Item Date' do
    create_new_item_date(DateTime.current)
    sleep 0.5
    target = @quote.line_item_dates.last
    assert_selector 'h1', text: @quote.name
    assert_text I18n.l(target.date, format: :long)
    within id: dom_id(target) do
      click_on 'Delete'
    end
    page.driver.browser.switch_to.alert.accept
    assert_selector 'h1', text: @quote.name
    assert_no_text I18n.l(Date.current, format: :long)
  end

  test 'Add new item after prev date' do
    create_new_item_date(DateTime.current)
    create_new_item_date(DateTime.current + 1.day)

    assert_selector 'h1', text: @quote.name
    element = page.find("#line_item_date_#{@quote.line_item_dates.last.prev_date.to_param}")
    element.assert_sibling("#line_item_date_#{@quote.line_item_dates.last.to_param}")
  end

  test 'Add new item before prev date' do
    create_new_item_date(DateTime.current + 1.day)
    create_new_item_date(DateTime.current)
    create_new_item_date(DateTime.current + 2.days)

    assert_selector 'h1', text: @quote.name
    target_el = @quote.line_item_dates.where(date: DateTime.current + 1.day).first
    element = page.find("#line_item_date_#{target_el.to_param}")
    element.assert_sibling("#line_item_date_#{target_el.next_date.to_param}")
  end

  private

  def create_new_item_date(date)
    click_on 'New Date'
    fill_in 'line_item_date_date', with: date

    assert_selector 'h1', text: @quote.name
    click_on 'Create Line item date'
  end
end
