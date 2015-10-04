class CreateRecords < ActiveRecord::Migration
  def change
    create_table :records do |t|
      t.references :task,  index: true, foreign_key: true
      t.integer    :order, index: true, default: 0

      t.timestamps null: false
    end
  end
end
