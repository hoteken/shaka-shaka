class Song < ApplicationRecord
  belongs_to :artist
  belongs_to :product

  validates :song_title, presence: true
end
