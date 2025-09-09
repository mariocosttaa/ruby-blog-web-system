class Panel::DashboardController < ApplicationController
  include HashidHelper
  before_action :authenticate_user!  # protege todas as actions
  layout "panel/panel_layout"
  def index
    @total_posts = Post.all.count
    @total_categories = Category.all.count
    @total_tags = Tag.all.count
    @total_post_comemts = PostComment.all.count
    posts = Post.all.order(created_at: :desc).limit(5)
    @posts = hashify_ids(posts, HASHIDS_TAG)
  end
end
