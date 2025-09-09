class PostTag < ApplicationRecord
  belongs_to :post, optional: false
  belongs_to :tag, optional: false
end
