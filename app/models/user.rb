class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_one_attached :profile_image, dependent: :destroy
  attr_accessor :current_password

  validates :name, presence: true, length: { minimum: 3 }
  validates :email, presence: true
  validates :password, length: { minimum: 6 }, allow_blank: true

  def self.looks(searchdata)
    # 部分一致
    user = User.where("name LIKE ?", "%#{searchdata}%")
    return user
  end

  GUEST_USER_EMAIL = "guest@example.com"

  def self.guest
    find_or_create_by!(email: GUEST_USER_EMAIL) do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "guestuser"
    end
  end
end