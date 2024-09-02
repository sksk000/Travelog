class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  has_one_attached :profile_image, dependent: :destroy

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

  GUEST_USER_EMAIL = "guest@example.com"

  def self.guest
    find_or_create_by!(email: GUEST_USER_EMAIL) do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "guestuser"
    end
  end
end