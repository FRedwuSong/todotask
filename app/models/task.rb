# frozen_string_literal: true

class Task < ApplicationRecord
  include AASM

  aasm column: 'state' do
    # 待處理 pending
    state :pending, initial: true
    # 進行中 process
    state :process
    # 完成 done
    state :completed

    event :processing do
      transitions from: :pending, to: :process
    end

    event :completing do
      transitions from: :process, to: :complete
    end
  end
  scope :sort_by_created_at_asc, -> { order(created_at: :asc) }
  scope :sort_by_created_at_desc, -> { order(created_at: :desc) }
  scope :sort_by_end_time_asc, -> { order(end_time: :asc) }
  scope :sort_by_end_time_desc, -> { order(end_time: :desc) }
  scope :sort_by_priority_asc, -> { order(priority: :asc) }
  scope :sort_by_priority_desc, -> { order(priority: :desc) }

  validates :title, presence: true
  validates :content, presence: true
  validates :end_time, presence: true

  enum priority: %i[low medium high]
  # {"low"=>0, "medium"=>1, "high"=>2}

  def self.ransackable_attributes(_auth_object = nil)
    %w[content created_at end_time id state title updated_at]
  end
end
