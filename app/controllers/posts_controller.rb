class PostsController < ApplicationController
  before_action :set_post, only: %i[edit update show destroy]

  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
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
  end

  def update
    if @post.update(post_params)
      redirect_to @post
    else
      render 'edit'
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
    params[:post].permit(:title, :text)
  end

  def set_post
    @post = current_user.posts.find(params[:id])
  end
end
