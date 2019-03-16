class Cart < ApplicationRecord
  has_many :products, through: :cart_products
  has_many :cart_products
end
