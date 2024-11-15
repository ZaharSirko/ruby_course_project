class Product < ApplicationRecord
  has_one_attached :image_url
  has_many :cart_items
  has_many :carts, through: :cart_items
end
