# README

## userテーブル
|Column|Type|Options|
|------|----|-------|
|nickname|string|null: false|
|email|string|null: false, unique: true|
|password|string|null: false, password_length: ７..128|
|last_name|string|null: false|
|first_name|string|null: false|
|last_name_kana|string|null: false|
|first_name_kana|string|null: false|
|date_of_birth|integer|null: false|
|biography|string|
|avatar_image|string|
### Association
has_one :address
has_one :credit-card
has_many :orders
has_many :items

## addressテーブル
|Column|Type|Options|
|------|----|-------|
|ship_last_name|string|null: false|
|ship_first_name|string|null: false|
|ship_last_name_kana|string|null: false|
|ship_first_name_kana|string|null: false|
|postcode|integer|null: false|
|prefecture|string|null: false|
|city|string|null: false|
|block|string|null: false|
|building|string|
|ship_phone_number|integer|
|user_id|references|null: false, foreign_key: true|
### Association
belongs_to :users