class AddUserToTask < ActiveRecord::Migration
  def change
    add_reference :tasks, :user, index: true, foreign_key: true
  end
end
