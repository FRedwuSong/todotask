# frozen_string_literal: true

class AddStateToTasks < ActiveRecord::Migration[7.0]
  def change
    add_column :tasks, :state, :string
  end
end
