class Place < ApplicationRecord
  belongs_to :post
  geocoded_by :address
  after_validation :geocode
  has_one_attached :image

  validates :address, presence: true
  validates :place_name, presence: true
end
