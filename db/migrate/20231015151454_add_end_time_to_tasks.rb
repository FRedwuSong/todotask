# frozen_string_literal: true

class AddEndTimeToTasks < ActiveRecord::Migration[7.0]
  def change
    add_column :tasks, :end_time, :datetime
  end
end
