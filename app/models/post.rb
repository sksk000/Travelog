class Post < ApplicationRecord

  belongs_to :user
  has_many :comments, dependent: :destroy

  validates :title, presence: true
  validates :body, presence: true

  geocoded_by :address
  after_validation :geocode

  enum season: { spring: 0, summer: 1, fall: 2, winter: 3 }
  enum place: { abroad: 0, domestic: 1 }
  enum night: { onenight: 0, twonight: 1, threenight: 2, fournight: 3, fivenight: 4 }
  enum people: { oneperson: 0, twopersons: 1, threepersons: 2, fourpersons: 3, fivepersons: 4 }


  def self.looks(searchdata,condition)
    # 部分一致
    if condition == "PartialMatch"
      @post = Post.where("title LIKE?","%#{searchdata}%")
    elsif condition == "PerfectMatch"
      @post = Post.where(title: searchdata)
    end
  end
end
