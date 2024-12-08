json.data do
  json.places do
    json.array! @place do |place|
      json.address place.address
      json.latitude place.latitude
      json.longitude place.longitude
      json.place_name place.place_name
      json.comment place.comment
      json.image place.image.present? ? url_for(place.image) : asset_path('no_image.jpg')
      json.good place.good
      json.id place.id
      json.place_num place.place_num
    end
  end
  json.ratyimgpath_on asset_path('star-on.png')
  json.ratyimgpath_off asset_path('star-off.png')
end