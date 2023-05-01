# frozen_string_literal: true

require 'test_helper'

class QuoteTest < ActiveSupport::TestCase
  test '#total_price returns the total price of the line_items' do
    assert_equal 2500, quotes(:first).total_price
  end
end
