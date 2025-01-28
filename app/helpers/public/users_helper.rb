module Public::UsersHelper
  def user_index_image(user, size, options = {})
    options[:class] ||= "card-img-top"
    options[:size] = size

    if user.profile_image.present?
      image_tag(user.profile_image, options)
    else
      image_tag(asset_path('no_image.jpg'), options)
    end
  end

  def user_profile_image(user, size, options = {})
    options[:size] = size
    if user.profile_image.present?
      image_tag(rails_blob_path(user.profile_image), options)
    else
      image_tag(asset_path('no_image.jpg'), options)
    end
  end
end
