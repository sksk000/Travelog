class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy

  validates :name, presence: true
  validates :email, presence: true

  def self.looks(searchdata,condition)
    # 部分一致
    if condition == "PartialMatch"
      @user = User.where("name LIKE?", "%#{searchdata}%")
    elsif condition == "PerfectMatch"
      @user = User.where(name: searchdata)
    end
  end
end
