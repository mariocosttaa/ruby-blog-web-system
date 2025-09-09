class PostCategory < ApplicationRecord
  belongs_to :post, optional: false
  belongs_to :category, optional: false
end
