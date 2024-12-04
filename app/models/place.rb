class Place < ApplicationRecord
  belongs_to :post
  reverse_geocoded_by :latitude, :longitude
  after_validation :reverse_geocode
  has_one_attached :image, dependent: :destroy

  validates :place_name, presence: true
end
