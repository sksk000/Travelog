class Post < ApplicationRecord

  belongs_to :user
  has_many :comments, dependent: :destroy

  validates :title, presence: true
  validates :body, presence: true

  geocoded_by :address
  after_validation :geocode

  def self.looks(searchdata,condition)
    # 部分一致
    if condition == "PartialMatch"
      @post = Post.where("title LIKE?","%#{searchdata}%")
    elsif condition == "PerfectMatch"
      @post = Post.where(title: searchdata)
    end
  end
end
