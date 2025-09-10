class Public::ArticlesController < ApplicationController
  include HashidHelper
  layout "public/public_layout"
  before_action :set_post, only: [ :create_comment, :show ]

  def index
    posts = Post.where(status: true).order(created_at: :desc)
    @posts = hashify_ids(posts, HASHIDS_POST)
  end

  def show  
    @new_comment = @post.comments.build
  end

  def create_comment
    @new_comment = @post.comments.new(comment_params)
    @new_comment.post = @post
    if @new_comment.save
      redirect_to public_article_show_path(@post.slug), notice: "Comment was successfully created."
    else
      render :show, status: :unprocessable_entity
    end
  end

  private
  def comment_params
    params.require(:post_comment).permit(:name, :email, :comment)
  end

  private
  def set_post
      slug = params[:slug]
      post = Post.where(status: true).find_by(slug: slug)
      if post.present?
        @post = hashify_ids(post, HASHIDS_POST)
      else
          redirect_to public_home_index_path, type: :danger, status: 404, alert: "Post not found." unless @post
      end
  end
end
