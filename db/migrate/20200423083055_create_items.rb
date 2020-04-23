class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string     :name,                null: false
      t.text       :description,         null: false
      t.references :category_id,         null: false, foreign_key: true
      t.string     :condition,           null: false
      t.string     :delivery_charge,     null: false
      t.string     :delivery_prefecture, null: false
      t.string     :delivery_dates,      null: false
      t.integer    :price,               null: false
      t.integer    :status,              null: false, default: 1
      t.timestamps
    end
  end
end
