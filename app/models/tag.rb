class Tag < ApplicationRecord
  has_many :post_tags, dependent: :destroy
  has_many :posts, through: :post_tags

  def self.looks(searchdata)
    tag = find_by(name: searchdata)
    tag&.posts
  end
end
