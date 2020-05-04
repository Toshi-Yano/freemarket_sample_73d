class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :delivery_charge
  belongs_to_active_hash :delivery_dates
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :condition

  belongs_to :category
  belongs_to :user
  has_one :order
  has_many :images
  accepts_nested_attributes_for :images, allow_destroy: true

  validates :name, presence: true
  validates :description, presence: true
  validates :category_id, presence: true
  validates :condition_id, presence: true
  validates :delivery_charge_id, presence: true
  validates :prefecture_id, presence: true
  validates :delivery_dates_id, presence: true
  validates :price, presence: true
  validates :status, presence: true
end