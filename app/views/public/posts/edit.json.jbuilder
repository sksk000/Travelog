json.data do
  json.good @post.good
  json.ratyimgpath_on asset_path('star-on.png')
  json.ratyimgpath_off asset_path('star-off.png')
  json.imagepath Rails.application.routes.url_helpers.rails_blob_url(@post.image, only_path: true) if @post.image.attached?
  json.prefectures do
    json.array! @prefectures do |prefecture|
      json.prefecture prefecture.prefecture
    end
  end
  json.tags do
    json.array! @tags do |tag|
      json.tag tag.name
    end
  end
end
