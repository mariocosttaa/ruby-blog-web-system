class PostCategory < ApplicationRecord
  validates :name, presence: true,  length: { maximum: 100 }, uniqueness: { case_sensitive: false }
  validates :description, presence: true, length: { maximum: 1000 }
end
