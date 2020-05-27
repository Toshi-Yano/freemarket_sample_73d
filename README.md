# README

# フリマアプリ（メルカリコピー）
プログラミングスクールでのチーム開発課題です。
- URL:  http://52.192.112.245/
- ID :  haku
- Pass: mizuki
- テストアカウント
 - メールアドレス: yamadatarou@gmail.com
 - パスワード:    abcd1234
 
# 開発担当箇所一覧と確認方法
- ユーザー登録機能（ウィザード形式を用いたユーザー情報・住所情報の登録機能）  
　→　確認方法：サインアップページ
- クレジットカード登録・商品購入機能（pay.jpを用いたクレジットカード情報登録機能）  
　→　確認方法：商品詳細 → 購入ページ  
 　　　　　　　　マイページ → カード情報
- 商品検索・並べ替え機能（ransackを用いた商品詳細検索・並べ替え機能）  
　→　確認方法：キーワード検索 → ヘッダー検索ボックス  
　　　　　　　　詳細検索・並べ替え → キーワード検索後の一覧画面

## usersテーブル
|Column|Type|Options|
|------|----|-------|
|nickname|string|null: false|
|email|string|null: false, unique: true|
|password|string|null: false, password_length: ７..128|
|last_name|string|null: false|
|first_name|string|null: false|
|last_name_kana|string|null: false|
|first_name_kana|string|null: false|
|date_of_birth|date|null: false|
|biography|text||
|avatar_image|string||
### Association
- has_one :address
- has_one :credit_card
- has_many :orders
- has_many :items

## addressesテーブル
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
|building|string||
|ship_phone_number|integer||
|user_id|reference|null: false, foreign_key: true|
### Association
- belongs_to :user

## ordersテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|reference|null: false, foreign_key: true|
|item_id|reference|null: false, foreign_key: true|
### Association
- belongs_to :user
- belongs_to :item

## credit_cardsテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|reference|null: false, foreign_key: true|
|card_number|integer|null: false, unique: true|
|expiration_year|integer|null: false|
|expiration_month|integer|null: false|
|security_code|integer|null: false|
### Association
- belongs_to :user

## items テーブル
|Column|Type|Options|
|------|----|-------|
|user_id|reference|null: false, foreign_key: true|
|name|string|null: false, name_length: 1..40|
|description|text|null: false, description_length: 1..1000|
|category_id|reference|null: false, foreign_key: true|
|condition|string|null: false|
|delivery_charge|string|null: false|
|delivery_prefecture|string|null: false|
|delivery_dates|string|null: false|
|price|integer|null: false, price: 300..9999999|
|status|integer|default: 1|  <!-- 1: 購入可, 2: 購入済み -->
### Association
- belongs_to :user
- belongs_to :category
- has_one :order
- has_many :images

## images テーブル
|Column|Type|Options|
|------|----|-------|
|image|string|null: false|
|item_id|reference|foreign_key: true|
### Association
- belongs_to :item

## categories テーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|ancestry|integer|null: false|
### Association
- has_many :items
