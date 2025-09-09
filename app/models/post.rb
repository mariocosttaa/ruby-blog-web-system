class Post < ApplicationRecord
  belongs_to :user
  has_many :post_categories
  has_many :categories, through: :post_categories
  has_many :post_tags
  has_many :tags, through: :post_tags
  has_one_attached :image

  validates :title, presence: true, length: { maximum: 100 }, uniqueness: { case_sensitive: false }
  validates :description, presence: true, length: { minimum: 100 }
  validates :status, inclusion: { in: [ true, false ] }
end
