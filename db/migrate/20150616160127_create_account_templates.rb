class CreateAccountTemplates < ActiveRecord::Migration
  def change
    create_table :account_templates, id: false do |t|
      t.string  :number,           index: true, default: ""
      t.string  :name,             index: true, default: ""
      t.string  :close_via_number, index: true
      t.boolean :has_initial,      index: true, default: false
      t.integer :order,            index: true, default: 0

      t.timestamps null: false
    end
    execute %Q{ ALTER TABLE account_templates ADD PRIMARY KEY (number); }
  end
end
