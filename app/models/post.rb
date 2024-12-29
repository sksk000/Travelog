class Post < ApplicationRecord

  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :places, dependent: :destroy
  has_one_attached :image, dependent: :destroy
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags
  has_many :post_prefectures, dependent: :destroy


  validates :title, presence: true
  validates :body, presence: true

  enum season: { 春: 0, 夏: 1, 秋: 2, 冬: 3 }
  enum place: { 海外旅行: 0, 国内旅行: 1 }
  enum night: { 一泊: 0, 二泊: 1, 三泊: 2, 四泊: 3, 五泊: 4, 六泊以上: 5 }
  enum people: { 一人: 0, 二人: 1, 三人: 2, 四人: 3, 五人: 4, 六人以上: 5 }

  def self.looks(searchdata, month, prefectures, night, people, postmonth, postgood)
    # 部分一致
    @post = Post.where("title LIKE?","%#{searchdata}%")
    # 旅行月
    unless month == nil
      @post = @post.where(travelmonth: month)
    end

    # 都道府県名
    unless prefectures == "all_prefectures"
      @post = @post.joins(:post_prefectures).where(post_prefectures: { prefecture: prefectures })
    end

    # 宿泊日数フィルター
    unless night == "all_nights"
      @post = @post.where(night: night)
    end

    # 人数フィルター
    unless people == "all_people"
      @post = @post.where(people: people)
    end

    # 投稿月
    unless postmonth == nil
      if Rails.env.development?
        # 開発環境用
        # 月を2桁形式に整形する
        formatted_months = postmonth.map { |m| format('%02d', m) }

        # SQLiteの場合、created_atの月と比較する
        @post = @post.where("strftime('%m', posts.created_at) IN (?)", formatted_months)
      elsif Rails.env.production?
        # 本番環境用
        @post = @post.where("EXTRACT(MONTH FROM created_at) IN (?)", postmonth)
      end
    end

    # 観光点数
    unless postgood == nil
      @post = @post.where(good: postgood)
    end

    return @post

  end
end
