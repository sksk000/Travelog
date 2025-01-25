class Place < ApplicationRecord
  belongs_to :post
  reverse_geocoded_by :latitude, :longitude
  after_validation :reverse_geocode
  has_one_attached :image, dependent: :destroy

  validates :place_name, presence: true

  def self. getPlaces(id)
    Place.where(post_id: id).order(:place_num)
  end

  def self.createPlace(place_params, post_id)
    errors = []
    place_params.each do |place_param|
      place = Place.new(place_param.merge(post_id: post_id))
      unless place.save
        errors << place.errors.full_messages
        break
      end
    end
    errors
  end
end
