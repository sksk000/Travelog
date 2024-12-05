json.data do
  json.items do
    json.places do
      json.array! @user.posts do |post|
        json.array! post.places do |place|
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
    end

    json.ratyimgpath_on asset_path('star-on.png')
    json.ratyimgpath_off asset_path('star-off.png')
  end
end