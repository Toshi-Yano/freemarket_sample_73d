class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :delivery_charge
  belongs_to_active_hash :delivery_date
  belongs_to_active_hash :prefecture
  
  belongs_to :category
  belongs_to :user
  has_many :images
  belongs_to :order
  
end
