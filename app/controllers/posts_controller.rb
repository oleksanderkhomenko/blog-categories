class PostsController < ApplicationController
  before_action :set_post, only: %i[show destroy like edit update like_users]

  def index
    if params[:category_id].present?
      @posts = Post.where(category_id: params[:category_id])
    else
      @posts = Post.all
    end
  end

  def new
    redirect_to new_category_path(from_post: true) if Category.count.zero?
    @post = Post.new
    @categories = Category.all.arrange(order: :created_at)
  end

  def create
    @post = current_user.posts.new(post_params)
    if @post.save
      redirect_to @post
    else
      render 'new'
    end
  end

  def edit
    authorize @post
    @categories = Category.all.arrange(order: :created_at)
  end

  def update
    authorize @post
    @post.update(post_params)
    redirect_to @post
  end

  def show
    @post.increment!(:views_count)
    if current_user.votes.where(post_id: @post).count.zero?
      @vote = true
    else
      @vote = false
    end
  end

  def destroy
    authorize @post
    @post.destroy
    redirect_to posts_path
  end

  def like
    vote = Vote.where(user_id: current_user.id, post_id: @post.id)
    if vote.count.zero?
      @post.like(current_user)
    else
      @post.unlike(current_user, vote.first)
    end
    redirect_to @post
  end

  def like_users
    @users = @post.votes.map { |v| v.user.email }
  end

  private

  def post_params
    params[:post].permit(:title, :text, :category_id)
  end

  def set_post
    @post ||= Post.find(params[:id])
  end

end
