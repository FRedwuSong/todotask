# frozen_string_literal: true

class AddIndexOfTasksTitle < ActiveRecord::Migration[7.0]
  def change
    add_index :tasks, :title
  end
end
