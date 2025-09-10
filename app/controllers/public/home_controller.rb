class Public::HomeController < ApplicationController
  include HashidHelper
  layout "public/public_layout"
  def index
    posts = Post.all.order(created_at: :desc).limit(3)
    tags = Tag.all.limit(25)
    categories = Category.all.limit(10)
    @posts = hashify_ids(posts, HASHIDS_POST)
    @tags = hashify_ids(tags, HASHIDS_TAG)
    @categories = hashify_ids(categories, HASHIDS_CATEGORY)
  end
end
