class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
      t.string     :ship_last_name,       null: false
      t.string     :ship_first_name,      null: false
      t.string     :ship_last_name_kana,  null: false
      t.string     :ship_first_name_kana, null: false
      t.integer    :postcode,             null: false
      t.string     :prefecture,           null: false
      t.string     :city,                 null: false
      t.string     :block,                null: false
      t.string     :building
      t.integer    :ship_phone_number
      t.references :user,                 null: false, foreign_key: true
      t.timestamps
    end
  end
end