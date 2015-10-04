class AddCurrentTaskToUser < ActiveRecord::Migration
  def change
    add_reference :users, :current_task, references: :task, index: true
    add_foreign_key :users, :tasks, column: :current_task_id
  end
end
