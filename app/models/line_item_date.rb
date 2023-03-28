# frozen_string_literal: true

class LineItemDate < ApplicationRecord
  after_create_commit -> { broadcast_between }
  after_update_commit -> { broadcast_between }
  after_destroy_commit -> { broadcast_remove_to [quote, 'line_item_dates'] }
  # broadcasts_to -> (line_item_date) { [line_item_date.quote, 'line_item_dates'] }, inserts_by: :prepend
  belongs_to :quote
  has_many :line_items, dependent: :destroy

  validates :date, presence: true, uniqueness: { scope: :quote_id }

  scope :ordered, -> { order(date: :asc) }

  #
  # Return prev date or nil if doesn't exist.
  #
  # @return [LineItemDate, Nil]
  #
  def prev_date
    quote.line_item_dates.where('date < ?', date).ordered.last
  end

  #
  # Return next date or nil if doesn't exist.
  #
  # @return [LineItemDate, Nil]
  #
  def next_date
    quote.line_item_dates.where('date > ?', date).ordered.first
  end

  private

  def broadcast_between
    broadcast_remove_to [quote, 'line_item_dates']
    if next_date.present?
      broadcast_action_later_to [quote, 'line_item_dates'], action: :before, target: next_date
    elsif prev_date.present?
      broadcast_action_later_to [quote, 'line_item_dates'], action: :after, target: prev_date
    else
      broadcast_prepend_later_to [quote, 'line_item_dates']
    end
  end
end
