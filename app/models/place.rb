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

  def self.update_Or_CreatePlace(post_id, place_params)
    errors = []
    if place_params[:id] == "null"
      new_place = Place.new(
        place_name: place_params[:place_name],
        comment: place_params[:comment],
        latitude: place_params[:latitude],
        longitude: place_params[:longitude],
        good: place_params[:good],
        place_num: place_params[:place_num],
        post_id: post_id,
        image: place_params[:image]
      )
      unless new_place.save
        errors = new_place.errors.full_messages.join(', ')
      end
    else
      # 既存のレコードの更新処理
      place = Place.find_by(id: place_params[:id])
      if place
        place.image.attach(place_params[:image]) if place_params[:image].present?

        unless place.update(
          place_name: place_params[:place_name],
          comment: place_params[:comment],
          latitude: place_params[:latitude],
          longitude: place_params[:longitude],
          good: place_params[:good],
          place_num: place_params[:place_num]
        )
          errors = place.errors.full_messages.join(', ')
        end
      end
    end
    errors
  end
end
