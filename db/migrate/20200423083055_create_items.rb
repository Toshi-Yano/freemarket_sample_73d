class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.references :user,                null: false, foreign_key: true
      t.string     :name,                null: false
      t.text       :description,         null: false
      t.references :category,            null: false, foreign_key: true
      t.integer     :condition_id,           null: false
      t.integer     :delivery_charge_id,     null: false
      t.integer     :prefecture_id,          null: false
      t.integer     :delivery_dates_id,      null: false
      t.integer    :price,               null: false
      t.integer    :status,              null: false, default: 1
      t.timestamps
    end
  end
end
