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
      end
    end
    json.title @post.title
    json.body @post.body
    json.is_release @post.is_release
    json.is_stoprelease @post.is_stoprelease
    json.spot @post.spot
    json.good @post.good
    json.latitude @target_place_latitude
    json.longitude @target_place_longitude
  end
end