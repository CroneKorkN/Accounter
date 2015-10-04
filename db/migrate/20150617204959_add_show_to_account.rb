class AddShowToAccount < ActiveRecord::Migration
  def change
    add_column :accounts, :show, :boolean, default: false
    add_index :accounts, :show
  end
end
