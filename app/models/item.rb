class Item < ApplicationRecord
  belongs_to :category
  belongs_to :user
  has_many :images
  belongs_to :order
end
