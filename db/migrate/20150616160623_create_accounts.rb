class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string     :number,           index: true
      t.references :task,             index: true, foreign_key: true
      t.decimal    :initial,          precision: 15, scale: 2, default: 0
    
      t.timestamps null: false
    end
  end
end
