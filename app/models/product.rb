class Product < ApplicationRecord
  has_many :carts, through: :cart_products
  has_many :cart_products
  has_many :songs
  belongs_to :label
  belongs_to :genre

  validates :explanation, presence:true,length: { maximum: 200 }
  validates :product_title, presence:true,length: { maximum: 50 }
  validates :product_price, presence: true
  validates :stock, presence: true

  attachment :image

end
