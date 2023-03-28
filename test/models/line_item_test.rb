# frozen_string_literal: true

require 'test_helper'

class LineItemTest < ActiveSupport::TestCase
  setup do
    @line_item = line_items(:room_today)
  end
  test 'LineItem belongs to field :line_item_date' do
    assert @line_item.line_item_date.is_a?(LineItemDate)
  end
  test 'LineItem respond to field :name' do
    assert @line_item.respond_to?(:name)
    assert @line_item.name.is_a?(String)
  end
  test 'LineItem respond to field :description' do
    assert @line_item.respond_to?(:description)
    assert @line_item.description.is_a?(String)
  end
  test 'LineItem respond to field :quantity' do
    assert @line_item.respond_to?(:quantity)
    assert @line_item.quantity.is_a?(Numeric)
  end
  test 'LineItem respond to field :unit_price' do
    assert @line_item.respond_to?(:quantity)
    assert @line_item.unit_price.is_a?(Numeric)
  end
end
