class PostsController < ApplicationController
  before_action :set_post, only: %i[show destroy]

  def index
    @posts = Post.all
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

  def show
  end

  def destroy
    @post.destroy
    redirect_to posts_path
  end

  private

  def post_params
    params[:post].permit(:title, :text, :category_id)
  end

  def set_post
    @post = current_user.posts.find(params[:id])
  end
end
