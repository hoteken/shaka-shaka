class Destination < ApplicationRecord
	belongs_to :user

	validates :destination_name, presence: true, length: { maximum: 30 }
	validates :destination_postcode, length: { is:7 }
	validates :destination_address, presence: true, length: { maximum: 100 }
end
