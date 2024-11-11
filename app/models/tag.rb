class Tag < ApplicationRecord
  has_many :posttags
  has_many :tags, through: :posttags
end
