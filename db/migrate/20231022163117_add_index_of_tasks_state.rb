# frozen_string_literal: true

class AddIndexOfTasksState < ActiveRecord::Migration[7.0]
  def change
    add_index :tasks, :state
  end
end
