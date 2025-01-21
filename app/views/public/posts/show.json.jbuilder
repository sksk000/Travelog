json.data do
  json.items do
    json.user do
      json.name @post.user.name
    end

    json.places do
      json.array! @post.places do |place|
        json.address place.address
        json.latitude place.latitude
        json.longitude place.longitude
        json.place_name place.place_name
        json.comment place.comment
        json.image place.image.present? ? url_for(place.image) : asset_path('no_image.jpg')
        json.good place.good
        json.id place.id
      end
    end
    json.title @post.title
    json.body @post.body
    json.is_release @post.is_release
    json.is_stoprelease @post.is_stoprelease
    json.good @post.good
    json.latitude @target_place_latitude
    json.longitude @target_place_longitude
    json.ratyimgpath_on asset_path('star-on.png')
    json.ratyimgpath_off asset_path('star-off.png')
  end
end
