class Label < ApplicationRecord
has_many :products
validates :label_name, presence: true
end

