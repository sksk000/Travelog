json.data do
  json.items do
    json.array!(@post) do |post|
      json.user do
        json.name post.user.name
      end
      json.address post.address
      json.latitude post.latitude
      json.longitude post.longitude
      t.title
      json.body
      json.is_release
      json.is_stoprelease
      json.spot
      json.good
    end
  end
end