class Public::TagsController < ApplicationController
  include HashidHelper
  layout "layouts/public/public_layout"

  def index
    tags = Tag.where(status: true).order("id DESC")
    @tags = hashify_ids(tags, HASHIDS_TAG)
  end

  def show
    slug = params[:slug]
    tag = Tag.where(status: true).where("LOWER(name) LIKE ?", "#{slug.downcase}")
    if tag.present?
      tag = tag.first
      posts = Post.joins(:tags)
            .where(
              "LOWER(tags.name) LIKE :q AND posts.status = :status",
              q: "%#{slug.downcase}%",
              status: true
            ).distinct
            .order(created_at: :desc)

      @posts = hashify_ids(posts, HASHIDS_POST)
    else
     redirect_back fallback_location: root_path, type: :danger, status: 404, alert: "Tag not found!"
    end
  end
end
