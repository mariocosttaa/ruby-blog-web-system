class Public::SearchController < ApplicationController
  include HashidHelper
  layout "layouts/public/public_layout"

  def show
    query = params[:query]
    if query.present?
      posts = Post.joins(:categories, :tags)
                  .where(
                    "LOWER(posts.title) LIKE :q OR LOWER(posts.description) LIKE :q OR LOWER(categories.name) LIKE :q OR LOWER(tags.name) LIKE :q",
                    q: "%#{query.downcase}%"
                  ).distinct
                  .order(created_at: :desc)


      @posts = hashify_ids(posts, HASHIDS_POST)
    else
      @posts = nil
    end
  end
end
