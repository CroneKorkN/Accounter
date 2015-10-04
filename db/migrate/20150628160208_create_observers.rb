class CreateObservers < ActiveRecord::Migration
  def change
    create_table :observers do |t|
      t.string :session_id
      t.references :task, index: true, foreign_key: true
    end
    add_index :observers, :session_id
  end
end
