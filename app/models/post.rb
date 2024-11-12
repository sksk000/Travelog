class Post < ApplicationRecord

  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :places, dependent: :destroy
  has_one_attached :image, dependent: :destroy
  has_many :posttags
  has_many :tags, through: :posttags
  has_many :post_prefectures
  has_many :prefectures, through: :post_prefectures
  

  validates :title, presence: true
  validates :body, presence: true

  enum season: { 春: 0, 夏: 1, 秋: 2, 冬: 3 }
  enum place: { 海外旅行: 0, 国内旅行: 1 }
  enum night: { 一泊: 0, 二泊: 1, 三泊: 2, 四泊: 3, 五泊: 4, 六泊以上: 5 }
  enum people: { 一人: 0, 二人: 1, 三人: 2, 四人: 3, 五人: 4, 六人以上: 5 }
  enum prefecture: {
    北海道: 0,    青森: 1,    岩手: 2,
    宮城: 3,      秋田: 4,    山形: 5,
    福島: 6,      茨城: 7,    栃木: 8,
    群馬: 9,      埼玉: 10,   千葉: 11,
    東京: 12,     神奈川: 13, 新潟: 14,
    富山: 15,     石川: 16,   福井: 17,
    山梨: 18,     長野: 19,   岐阜: 20,
    静岡: 21,     愛知: 22,   三重: 23,
    滋賀: 24,     京都: 25,   大阪: 26,
    兵庫: 27,     奈良: 28,   和歌山: 29,
    鳥取: 30,     島根: 31,   岡山: 32,
    広島: 33,     山口: 34,   徳島: 35,
    香川: 36,     愛媛: 37,   高知: 38,
    福岡: 39,     佐賀: 40,   長崎: 41,
    熊本: 42,     大分: 43,   宮崎: 44,
    鹿児島: 45,   沖縄: 46
  }

  def self.looks(searchdata, month, prefectures, night, people, postmonth, postgood)
    # 部分一致
    @post = Post.where("title LIKE?","%#{searchdata}%")
    # 旅行月
    unless month == nil
      @post = Post.where(month: month)
    end

    # 都道府県名
    unless prefectures == "all_prefectures"
      @post = Post.where(prefecture: prefectures)
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
      if ActiveRecord::Base.connection.adapter_name == "SQLite"
        # 開発環境用
        @post = @post.where("strftime('%m', created_at) IN (?)", postmonth.map { |m| format('%02d', m) })
      elsif ActiveRecord::Base.connection.adapter_name == "MySQL"
        # 本番環境用
        @post = @post.where("EXTRACT(MONTH FROM created_at) IN (?)", postmonth)
      end
    end

    # 観光点数
    unless postgood == nil
      @post = @post.where(good: postgood.map)
    end

    return @post

  end
end
