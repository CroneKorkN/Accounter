class AddUpdatedAtToObservers < ActiveRecord::Migration
  def change
    add_column :observers, :updated_at, :datetime
  end
end
