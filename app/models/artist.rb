class Artist < ApplicationRecord
  has_many :songs
  has_many :products, through: :songs
  validates :artist_name, presence: true
end
