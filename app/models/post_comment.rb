class PostComment < ApplicationRecord
  belongs_to :post

  validates :name, presence: true, length: { maximum: 20 }
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :comment, presence: true, length: { maximum: 500 }
end
