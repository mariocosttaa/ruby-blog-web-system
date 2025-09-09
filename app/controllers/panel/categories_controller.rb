class Panel::CategoriesController < ApplicationController
  before_action :authenticate_user!  # protege todas as actions
  include HashidHelper
  before_action :set_category, only: [ :edit, :update, :destroy ]
  layout "panel/panel_layout"

  def index
    categories = Category.all.order(created_at: :desc)
    @categories = hashify_ids(categories, HASHIDS_CATEGORY)
  end


  def new
     @category = Category.new
  end

  def edit
  end

  def create
      @category = Category.new(category_params)
      # making slug from
      @category.slug = @category.name.to_s.parameterize(separator: "-")
      if @category.save
        redirect_to panel_categories_index_path, notice: "Category was successfully created."
      else
        render :new, status: :unprocessable_entity
      end
  end

  def update
      # Find Category
      @category.update(category_params)
      if @category.save
        redirect_to panel_categories_index_path, type: :success, notice: "Category was successfully updated."
      else
        render :edit, status: :unprocessable_entity
      end
  end
  def destroy
    @category.destroy
    redirect_to panel_categories_index_path, type: :success, notice: "Category was successfully deleted."
  end

  private
  def category_params
      params.require(:category).permit(:name, :description, :status)
  end

  def set_category
     id_hash = params[:id]
     unHash_id = HASHIDS_CATEGORY.decode(id_hash).first rescue nil

      @category = Category.find_by(id: unHash_id)
      redirect_to panel_categories_index_path, type: :danger, status: :unprocessable_entity, alert: "Category not found." unless @category
  end
end
