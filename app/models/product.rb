class Product < ApplicationRecord
  has_one_attached :image_url
  has_many :cart_items
  has_many :carts, through: :cart_items
  validates :stock, numericality: { greater_than_or_equal_to: 0, only_integer: true }
end
