json.data do
  json.items do
    json.user do
      json.name @post.user.name
    end
    json.address @post.address
    json.latitude @post.latitude
    json.longitude @post.longitude
    json.title @post.title
    json.body @post.body
    json.is_release @post.is_release
    json.is_stoprelease @post.is_stoprelease
    json.spot @post.spot
    json.good @post.good
  end
end