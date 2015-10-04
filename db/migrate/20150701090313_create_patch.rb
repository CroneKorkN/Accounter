class CreatePatch < ActiveRecord::Migration
  def change
    create_table :patches do |t|
      t.references :observer, index: true, foreign_key: true
      t.references :patchable, index: true, polymorphic: true
      t.integer :method_id
    end
  end
end
