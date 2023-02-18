# frozen_string_literal: true

class Quote < ApplicationRecord
  validates :name, presence: true

  # after_create_commit -> { broadcast_prepend_later_to 'quotes' }
  # after_update_commit -> { broadcast_replace_later_to 'quotes' }
  # after_destroy_commit -> { broadcast_remove_to 'quotes' }
  # Those three callbacks are equivalent to the following single line
  broadcasts_to -> (_quote) { 'quotes' }, inserts_by: :prepend
  scope :ordered, -> { order(created_at: :desc) }
end
