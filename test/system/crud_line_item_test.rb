# frozen_string_literal: true

require 'application_system_test_case'

class CrudLineItemTest < ApplicationSystemTestCase
  include ActionView::Helpers::NumberHelper
  setup do
    login_as users(:accountant)
    @quote          = quotes(:first)
    @line_item_date = line_item_dates(:today)
    @line_item      = line_items(:room_today)
    visit quote_path(@quote)
  end

  test 'Create a New Line Item' do
    assert_selector 'h1', text: 'First quote'

    within id: dom_id(@line_item_date) do
      click_on 'Add item'
    end

    assert_selector 'h1', text: 'First quote'

    fill_in :line_item_name, with: 'Line Item One'
    fill_in :line_item_description, with: 'A cosy meeting room for 10 people'
    fill_in :line_item_quantity, with: 1
    fill_in :line_item_unit_price, with: 1000
    click_on 'Create Line item'
    assert_text 'Line Item One'
    assert_text 'A cosy meeting room for 10 people'
    assert_text '1'
    assert_text number_to_currency(1000.00)
    assert_text number_to_currency(@quote.total_price)
  end

  test 'Updating a Line Item' do
    assert_selector 'h1', text: 'First quote'
    within id: dom_id(@line_item) do
      click_on 'Edit'
    end
    assert_selector 'h1', text: 'First quote'
    fill_in :line_item_name, with: 'New item name'
    fill_in :line_item_quantity, with: 2
    click_on 'Update Line item'
    assert_text 'New item name'
    assert_text '2'
    assert_text number_to_currency(@quote.total_price)
  end

  test 'Destroy a Line Item' do
    assert_selector 'h1', text: 'First quote'
    within id: dom_id(@line_item_date) do
      within id: dom_id(@line_item) do
        click_on 'Delete', match: :first
      end
      assert_no_text 'Meeting room'
    end
    assert_selector 'h1', text: 'First quote'
    assert_text number_to_currency(@quote.total_price)
  end
end
