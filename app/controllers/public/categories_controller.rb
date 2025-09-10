class Public::CategoriesController < ApplicationController
  include HashidHelper
  layout "layouts/public/public_layout"
  def index
    categories = Category.where(status: true).order("id DESC")
    @categories = hashify_ids(categories, HASHIDS_CATEGORY)
  end

  def show
    slug = params[:slug]
    category = Category.where(status: true).find_by(slug: slug)
    if category.present?
      posts = Post.joins(:categories)
            .where(
              "LOWER(categories.name) LIKE :q AND posts.status = :status",
              q: "%#{slug.downcase}%",
              status: true
            ).distinct
            .order(created_at: :desc)

      @posts = hashify_ids(posts, HASHIDS_POST)
    else
     redirect_back fallback_location: root_path, type: :danger, status: 404, alert: "category not found!"
    end
  end
end
