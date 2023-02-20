# frozen_string_literal: true

require 'application_system_test_case'

class QuotesTest < ApplicationSystemTestCase
  setup do
    login_as users(:accountant)
    @quote = quotes(:first)
  end

  test 'creating a new Quote' do
    visit quotes_path
    assert_selector 'h1', text: 'Quotes'

    click_on 'New quote'
    fill_in 'Name', with: 'Capybara quote'

    assert_selector 'h1', text: 'Quotes'
    click_on 'Create Quote'

    assert_selector 'h1', text: 'Quotes'
    assert_text 'Capybara quote'
  end

  test 'Showing a quote' do
    visit quotes_path
    click_link @quote.name
    assert_selector 'h1', text: @quote.name, count: 1
  end

  test 'Updating a quote' do
    visit quotes_path
    assert_selector 'h1', text: 'Quotes'

    click_on 'Edit', match: :first
    fill_in 'Name', with: 'Updated quote'

    assert_selector 'h1', text: 'Quotes'
    click_on 'Update Quote'

    assert_selector 'h1', text: 'Quotes'
    assert_text 'Updated quote'
  end

  test 'Edit can be Canceled' do
    visit quotes_path
    assert_selector 'h1', text: 'Quotes'

    click_on 'Edit', match: :first
    fill_in 'Name', with: 'Updated quote'
    click_on 'Cancel', match: :first

    assert_selector 'h1', text: 'Quotes'
    assert_text @quote.name
  end

  test 'Destroying a quote' do
    visit quotes_path
    assert_text @quote.name

    click_on 'Delete', match: :first
    assert_no_text @quote.name
  end

  test 'No access to other company quotes' do
    visit quotes_path
    assert_no_text quotes(:third).name
  end
end
