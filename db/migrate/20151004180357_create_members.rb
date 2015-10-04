class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.references :user, index: true, foreign_key: true
      t.string :name
      t.string :email
      t.string :password_digest

      t.timestamps null: false
    end
    add_index :members, :name
    add_index :members, :email
  end
end
