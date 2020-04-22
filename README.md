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
belongs_to :user

## ordersテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|referenc|null: false, foreign_key: true|
|item_id|referenc|null: false, foreign_key: true|
|status|integer||
### Association
belongs_to :user
belongs_to :item
belongs_to :credit-card

## credit-cardsテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|referenc|null: false, foreign_key: true|
|card_number|integer|null: false, unipue: true|
|expiration_year|integer|null: false|
|expiration_month|integer|null: false|
|security_code|integer|null: false|
### Association
belongs_to :user
belongs_to :users


## items テーブル
|Column|Type|Options|
|------|----|-------|
|user_id|reference|null: false, foreign_key: true|
|name|string|null: false|
|description|text|null: false|
|category_id|reference|null: false, foreign_key: true|
|condition|string|null: false|
|delivery_charge|string|null: false|
|derivery_prefecure|string|null: false|
|delivery_dates|integer|null: false|
|price|integer|null: false|
### Association
- belongs_to :user
- has_many :images

## images テーブル
|Column|Type|Options|
|------|----|-------|
|image|string|null: false|
|item-id|reference|foreign_key: true|
### Association

## categories テーブル
|Column|Type|Options|
|------|----|-------|
|id||
|name|string|null: false|
|ancestry|integer|null: false|
### Association
- has_many :items
