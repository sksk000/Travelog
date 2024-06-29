class Post < ApplicationRecord

  belongs_to :user
  has_many :comments, dependent: :destroy

  validates :title, presence: true
  validates :body, presence: true

  def self.looks(searchdata,condition)
    # 部分一致
    if condition == "PartialMatch"
      @post = Post.where("name LIKE?", searchdata)
    elsif condition == "PerfectMatch"
      @post = Post.where(title: searchdata)
    end
  end
end
