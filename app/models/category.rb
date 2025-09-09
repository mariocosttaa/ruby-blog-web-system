class Category < ApplicationRecord
  validates :name, presence: true,  length: { maximum: 100 }, uniqueness: { case_sensitive: false }
  validates :description, presence: false, length: { maximum: 1000 }
  validates :status, presence: false, inclusion: { in: [ true, false ] }
end
