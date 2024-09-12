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
        end
      end
    end
  end
end