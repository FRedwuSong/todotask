# frozen_string_literal: true

class Task < ApplicationRecord
  scope :sort_by_created_at_asc, -> { order(created_at: :asc) }
  scope :sort_by_created_at_desc, -> { order(created_at: :desc) }
  scope :sort_by_end_time_asc, -> { order(end_time: :asc) }
  scope :sort_by_end_time_desc, -> { order(end_time: :desc) }

  validates :title, presence: true
  validates :content, presence: true
  validates :end_time, presence: true
end
