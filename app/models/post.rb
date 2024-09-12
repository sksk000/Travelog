class Post < ApplicationRecord

  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :places, dependent: :destroy
  has_many_attached :images, dependent: :destroy

  validates :title, presence: true
  validates :body, presence: true

  enum season: { 春: 0, 夏: 1, 秋: 2, 冬: 3 }
  enum place: { 海外旅行: 0, 国内旅行: 1 }
  enum night: { 一泊: 0, 二泊: 1, 三泊: 2, 四泊: 3, 五泊: 4 }
  enum people: { 一人: 0, 二人: 1, 三人: 2, 四人: 3, 五人: 4 }


  def self.looks(searchdata,condition,season,place,night,people)
    # 部分一致
    if condition == "PartialMatch"
      @post = Post.where("title LIKE?","%#{searchdata}%")
    elsif condition == "PerfectMatch"
      @post = Post.where(title: searchdata)
    end

    # 季節フィルター
    unless season == 'all_seasons'
      @post = @post.where(season: season)
    end

    # 場所フィルター
    unless place == "all_places"
      @post = @post.where(place: place)
    end

    # 宿泊日数フィルター
    unless night == "all_nights"
      @post = @post.where(night: night)
    end

    # 人数フィルター
    unless people == "all_people"
      @post = @post.where(people: people)
    end

    return @post

  end
end
