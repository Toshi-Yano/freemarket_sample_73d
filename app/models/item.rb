class Item < ApplicationRecord
  belongs_to :category
  belongs_to :user
  has_one :order
  has_many :images
  accepts_nested_attributes_for :images, allow_destroy: true
end
