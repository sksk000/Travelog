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
    User.where("name LIKE ?", "%#{searchdata}%")
  end

  GUEST_USER_EMAIL = "guest@example.com".freeze

  def self.guest
    find_or_create_by!(email: GUEST_USER_EMAIL) do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "guestuser"
    end
  end

  def get_order_user_postdata(select)
    case select
    when 'newpost'
      posts.order(created_at: :desc)
    when 'comment'
      posts.left_joins(:comments).group(:id).order('COUNT(comments.id) DESC')
    else
      posts
    end
  end
end
