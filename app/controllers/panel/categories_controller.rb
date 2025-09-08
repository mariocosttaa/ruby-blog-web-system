class Panel::CategoriesController < ApplicationController
  before_action :set_post_category, only: [ :edit, :update, :destroy ]
  layout "panel/panel_layout"

  def index
      @post_categories = PostCategory.all.order(created_at: :desc)
  end

  def new
     @post_category = PostCategory.new
  end

  def edit
  end

  def create
      @post_category = PostCategory.new(post_category_params)
      # making slug from
      @post_category.slug = @post_category.name.to_s.parameterize(separator: "-")
      if @post_category.save
        redirect_to panel_categories_index_path, notice: "Category was successfully created."
      else
        render :new, status: :unprocessable_entity
      end
  end

  def update
      # Find Category
      @post_category.update(post_category_params)
      if @post_category.save
        redirect_to panel_categories_index_path, type: :success, notice: "Category was successfully updated."
      else
        render :edit, status: :unprocessable_entity
      end
  end
  def destroy
  end

  private
  def post_category_params
      params.require(:post_category).permit(:name, :description)
  end

  def set_post_category
      @post_category = PostCategory.find_by(id: params[:id])
      redirect_to panel_categories_index_path, type: :danger, status: :unprocessable_entity, alert: "Category not found." unless @post_category
  end
end
