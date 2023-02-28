# frozen_string_literal: true

class LineItemDate < ApplicationRecord
  broadcasts_to -> (line_item_date) { [line_item_date.quote, 'line_item_dates'] }, inserts_by: :prepend
  belongs_to :quote

  validates :date, presence: true, uniqueness: { scope: :quote_id }

  scope :ordered, -> { order(date: :asc) }
end
