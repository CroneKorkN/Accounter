class AddUserToPatch < ActiveRecord::Migration
  def change
    add_reference :patches, :user, index: true, foreign_key: true
  end
end
