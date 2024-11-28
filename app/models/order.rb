class Order < ApplicationRecord
  belongs_to :user
  validates :delivery_type, inclusion: { in: %w[standard express pickup], message: "не є дійсним типом доставки" }
  DELIVERY_TYPES = {
    "Стандартна доставка" => "standard",
    "Експрес-доставка" => "express",
    "Самовивіз з магазину" => "pickup"
  }.freeze
end
