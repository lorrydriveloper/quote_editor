# frozen_string_literal: true

require 'test_helper'

class LineItemDateTest < ActiveSupport::TestCase
  test '#prev_date returns a line_item_date with date less that instance' do
    assert_equal line_item_dates(:today), line_item_dates(:tomorrow).prev_date
  end
  test '#prev_date returns a nil if nopdate less that instance' do
    assert_nil line_item_dates(:today).prev_date
  end
  test '#next_date returns a line_item_date with date bigger that instance' do
    assert_equal line_item_dates(:next_week), line_item_dates(:tomorrow).next_date
  end
  test '#next_date returns a nil if no date bigger that instance' do
    assert_nil line_item_dates(:next_week).next_date
  end
end
