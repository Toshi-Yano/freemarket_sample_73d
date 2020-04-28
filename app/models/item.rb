class Item < ApplicationRecord
  belongs_to :category
  belongs_to :user
  has_many :images
  belongs_to :order
  
  accepts_nested_attributes_for :images, allow_destroy: true
end
