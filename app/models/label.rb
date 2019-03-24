class Label < ApplicationRecord
has_many :products
has_many :products, through: :songs
validates :artist_name, presence: true
end

