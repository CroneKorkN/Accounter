class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.references :record,  index: true, foreign_key: true
      t.references :account, index: true, foreign_key: true
      t.decimal    :value,   precision: 15, scale: 2, default: 0
      t.boolean    :debit_not_credit, default: true

      t.timestamps null: false
    end
  end
end
