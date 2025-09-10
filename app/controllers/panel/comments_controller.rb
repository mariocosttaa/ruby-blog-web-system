class Panel::CommentsController < ApplicationController
  before_action :authenticate_user!  # protege todas as actions
  include HashidHelper
  before_action :set_comment, only: [:update, :destroy]
  layout "panel/panel_layout"

  def index
    comments = PostComment.includes(:post).order(created_at: :desc)
    @comments = hashify_ids(comments, HASHIDS_COMMENT)
  end

  def update
    @comment.update(comment_params)
    if @comment.save
      redirect_to panel_comments_index_path, type: :success, notice: "Comment was successfully updated."
    else
      redirect_back fallback_location: panel_comments_index_path, type: :danger, status: :unprocessable_entity, notice: "Error updating Comment."
    end
  end

  def destroy
    @comment.destroy
    redirect_to panel_comments_index_path, type: :success, notice: "Comment was successfully deleted."
  end

  private
    def comment_params
      params.require(:post_comment).permit(:status)
    end

  private
    def set_comment
      id_hash = params[:id]
      unHash_id = HASHIDS_COMMENT.decode(id_hash).first rescue nil
      @comment = PostComment.find_by(id: unHash_id)
      redirect_to panel_comments_index_path, type: :danger, status: :unprocessable_entity, alert: "Comment not found." unless @comment
    end
end
