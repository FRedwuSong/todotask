# frozen_string_literal: true

class Task < ApplicationRecord
  scope :sort_by_created_at_asc, -> { order(created_at: :asc) }
  scope :sort_by_created_at_desc, -> { order(created_at: :desc) }

  validates :title, presence: true
  validates :content, presence: true
  validates :end_time, presence: true
end
