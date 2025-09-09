class Panel::TagsController < ApplicationController
  before_action :authenticate_user!  # protege todas as actions
  include HashidHelper
  before_action :set_tags, only: [ :edit, :update, :destroy ]
  layout "panel/panel_layout"
  def index
    tags = Tag.all.order(created_at: :desc)
    @tags = hashify_ids(tags, HASHIDS_TAG)
  end

  def new
    @tag = Tag.new
  end

  def create
    @tag = Tag.new(tags_params)
    if @tag.save
      redirect_to panel_tags_index_path, type: :success, notice: "Tag was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    @tag.update(tags_params)
    if @tag.save
      redirect_to panel_tags_index_path, type: :success, notice: "Tag was successfully updated."
    else
      redirect_back fallback_location: panel_tags_index_path, type: :danger, status: :unprocessable_entity, notice: "Error updating Tag."
    end
  end

  def destroy
    @tag.destroy
    redirect_to panel_tags_index_path, type: :success, notice: "Tag was successfully deleted."
  end

  private
    def tags_params
      params.require(:tag).permit(:name, :status)
    end

  private
    def set_tags
      id_hash = params[:id]
      unHash_id = HASHIDS_TAG.decode(id_hash).first rescue nil
      @tag = Tag.find_by(id: unHash_id)
      redirect_to panel_tags_index_path, type: :danger, status: :unprocessable_entity, alert: "Tag not found." unless @tag
    end
end
