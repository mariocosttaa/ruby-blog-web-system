class Public::ArticlesController < ApplicationController
  include HashidHelper
  layout "public/public_layout"

  def index
    posts = Post.all.order(created_at: :desc)
    @posts = hashify_ids(posts, HASHIDS_POST)
  end

  def show
    slug = params[:slug]
    post = Post.find_by(slug: slug)
    if post.present?
      @post = hashify_ids(post, HASHIDS_POST)
    else
        redirect_to home_index_path, type: :danger, status: :unprocessable_entity, alert: "Post not found." unless @post
    end
  end
end
