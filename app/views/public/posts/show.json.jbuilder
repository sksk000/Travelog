json.data do
  json.items do
    json.array!(@post) do |post|
      json.address post.address
      json.latitude post.latitude
      json.longitude post.longitude
    end
  end
end