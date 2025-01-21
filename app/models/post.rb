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
  enum night: { '1泊': 0, '2泊': 1, '3泊': 2, '4泊': 3, '5泊': 4, '6泊以上': 5 }
  enum people: { '1人': 0, '2人': 1, '3人': 2, '4人': 3, '5人': 4, '6人以上': 5 }

  def self.looks(searchdata, month, prefectures, night, people, postmonth, postgood)
    # 部分一致
    @post = Post.where("title LIKE?", "%#{searchdata}%")
    # 旅行月
    @post = @post.where(travelmonth: month) unless month.nil?

    # 都道府県名
    @post = @post.joins(:post_prefectures).where(post_prefectures: { prefecture: prefectures }) unless prefectures == "all_prefectures"

    # 宿泊日数フィルター
    @post = @post.where(night: night) unless night == "all_nights"

    # 人数フィルター
    @post = @post.where(people: people) unless people == "all_people"

    # 投稿月
    unless postmonth.nil?
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
    @post = @post.where(good: postgood) unless postgood.nil?

    @post
  end
end
