class Tag < ApplicationRecord
  has_many :posttags, dependent: :destroy
  has_many :tags, through: :posttags
end
