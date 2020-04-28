class ChangeDataDataofbirthToUser < ActiveRecord::Migration[5.2]
  def change
    change_column :users, :date_of_birth, :date
  end
end