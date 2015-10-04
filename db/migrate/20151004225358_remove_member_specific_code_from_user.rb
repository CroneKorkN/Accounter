class RemoveMemberSpecificCodeFromUser < ActiveRecord::Migration
  def change
    remove_column :users, :name
    remove_column :users, :email
    remove_column :users, :password_digest
  end
end
