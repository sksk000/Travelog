class PrefectureService
  def self.createprefecture(post, prefectures)
    prefectures.each do |prefecture|
      prefecture_value = PostPrefecture.prefectures[prefecture]
      PostPrefecture.create(post: post, prefecture: prefecture_value) unless post.post_prefectures.include?(prefecture_value)
    end
  end

  def self.updateprefecture(post, prefectures)
    prefectures.each do |prefecture|
      prefecture_value = PostPrefecture.prefectures[prefecture]
      post.post_prefectures.find_or_create_by(prefecture: prefecture_value)
    end

    post.post_prefectures.where.not(prefecture: prefectures).find_each do |post_prefecture|
      post.post_prefectures.delete(post_prefecture)
    end
  end
end