class Panel::PostsController < ApplicationController
  before_action :authenticate_user!  # protege todas as actions
  include HashidHelper
  before_action :set_post, only: [ :edit, :update, :destroy ]
  layout "panel/panel_layout"
  def index
    posts = Post.all.order(created_at: :desc)
    @posts = hashify_ids(posts, HASHIDS_POST)
  end

  def new
    categories = Category.all.order(created_at: :desc)
    tags = Tag.all.order(created_at: :desc)
    @categories = hashify_ids(categories, HASHIDS_CATEGORY)
    @tags = hashify_ids(tags, HASHIDS_TAG)
    @post = Post.new
  end

def create
  # Extrair categorias e tags
  category_names = post_params[:categories].to_a.map(&:strip).reject(&:blank?).uniq
  tag_names      = post_params[:tags].to_s.split(",").map(&:strip).reject(&:blank?).uniq

  # Validações manuais
  if category_names.empty?
    redirect_back fallback_location: panel_create_post_path, type: :danger, notice: "Categories are required." and return
  end

  if tag_names.empty?
    redirect_back fallback_location: panel_create_post_path, type: :danger, notice: "Tags are required." and return
  end

  # Transação atômica
  Post.transaction do
    @post = Post.new(post_params.except(:categories, :tags))
    @post.user = current_user
    @post.slug = @post.title.to_s.parameterize(separator: "-").downcase
    @post.image.attach(post_params[:image]) if post_params[:image].present?
    @post.save!

    # Criar ou associar categories
    categories = category_names.map do |name|
      slug = name.downcase.gsub(" ", "-")
      Category.find_or_create_by!(name: name, slug: slug, status: true)
    end
    @post.categories = categories

    # Criar ou associar tags
    tags = tag_names.map do |name|
      Tag.find_or_create_by!(name: name, status: true)
    end
    @post.tags = tags
  end

  redirect_to panel_posts_index_path, type: :success, notice: "Post was successfully created."

rescue ActiveRecord::RecordInvalid => e
  # Captura qualquer erro na transação
  categories = Category.all.order(created_at: :desc)
  tags = Tag.all.order(created_at: :desc)
  @categories = hashify_ids(categories, HASHIDS_CATEGORY)
  @tags = hashify_ids(tags, HASHIDS_TAG)
  @submitted_categories = category_names # Store submitted categories
  @submitted_tags = tag_names # Store submitted tags

  flash.now[:danger] = "There was an error creating the post: #{e.message}"
  render :new, status: :unprocessable_entity
end


  def edit
    categories = Category.all.order(created_at: :desc)
    tags = Tag.all.order(created_at: :desc)
    @categories = hashify_ids(categories, HASHIDS_CATEGORY)
    @tags = hashify_ids(tags, HASHIDS_TAG)
  end

  def update
  # Extrair categorias e tags
  category_names = post_params[:categories].to_a.map(&:strip).reject(&:blank?).uniq
  tag_names      = post_params[:tags].to_s.split(",").map(&:strip).reject(&:blank?).uniq

  # Validações manuais
  if category_names.empty?
  redirect_back fallback_location: panel_edit_post_path(@post), type: :danger, notice: "Categories are required." and return
  end

  if tag_names.empty?
  redirect_back fallback_location: panel_edit_post_path(@post), type: :danger, notice: "Tags are required." and return
  end

  # Transação atômica
  Post.transaction do
  @post.assign_attributes(post_params.except(:categories, :tags))
  @post.slug = @post.title.to_s.parameterize(separator: "-").downcase
  @post.image.attach(post_params[:image]) if post_params[:image].present?
  @post.save!

  # Criar ou associar categories
  categories = category_names.map do |name|
  slug = name.downcase.gsub(" ", "-")
  Category.find_or_create_by!(name: name, slug: slug, status: true)
  end
  @post.categories = categories

  # Criar ou associar tags
  tags = tag_names.map do |name|
  Tag.find_or_create_by!(name: name, status: true)
  end
  @post.tags = tags
  end

  redirect_to panel_posts_index_path, type: :success, notice: "Post was successfully updated."

  rescue ActiveRecord::RecordInvalid => e
  # Captura qualquer erro na transação
  categories = Category.all.order(created_at: :desc)
  tags = Tag.all.order(created_at: :desc)
  @categories = hashify_ids(categories, HASHIDS_CATEGORY)
  @tags = hashify_ids(tags, HASHIDS_TAG)

  flash.now[:danger] = "There was an error updating the post: #{e.message}"
  render :edit, status: :unprocessable_entity
  end

  def destroy
    @post.destroy
    redirect_to panel_posts_index_path, type: :success, notice: "Post was successfully deleted."
  end

  private
  def post_params
    params.require(:post).permit(
      :title,
      :description,
      :image,
      :status,
      :tags,
      categories: []   # ← importante, para permitir arrays            # tags você deixa como string (Tagify envia como CSV)
    )
  end

  private
  def set_post
    hash_id = params[:id]
    unhas_id = HASHIDS_POST.decode(hash_id).first rescue nil
    @post = Post.find_by(id: unhas_id)
    redirect_to panel_posts_index_path, type: :danger, status: :unprocessable_entity, alert: "Post not found." unless @post
  end
end
