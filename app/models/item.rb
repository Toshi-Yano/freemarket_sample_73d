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

  validates :name, presence: true, length: {maximum: 40}
  validates :description, presence: true, length: {maximum: 1000}
  validates :category_id, presence: true
  validates :condition_id, presence: true
  validates :delivery_charge_id, presence: true
  validates :prefecture_id, presence: true
  validates :delivery_dates_id, presence: true
  validates :price, presence: true, numericality: {greater_than: 300, less_than: 9999999}
  validates :status, presence: true
  validates_associated :images
  validates :images, presence: true
end