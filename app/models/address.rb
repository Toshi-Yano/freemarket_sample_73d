class Address < ApplicationRecord
  belongs_to :user, optional: true

  validates :ship_last_name,      presence: true
  validates :ship_first_name,     presence: true
  validates :ship_last_name_kana, presence: true, format: { with: /\A[ぁ-ん]+\z/ }
  validates :ship_first_name_kana, presence: true, format: { with: /\A[ぁ-ん]+\z/ }
  validates :postcode,            presence: true, format: { with: /\A\d{7}\z/ }
  validates :prefecture,          presence: true
  validates :city,                presence: true
  validates :block,               presence: true
end
