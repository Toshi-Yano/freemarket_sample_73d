class AddNullBirthofdateToUser < ActiveRecord::Migration[5.2]
  def change
    change_column_null :users, :date_of_birth, :true
  end
end
