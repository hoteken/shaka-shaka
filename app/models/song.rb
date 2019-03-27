class Song < ApplicationRecord
  belongs_to :artist
  belongs_to :product

  validates :song_title, presence: true
  validates :track_order, presence: true
  validates :disk_number, presence: true
end
