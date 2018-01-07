class CategoriesController < ApplicationController
  before_action :set_category, only: %i[show destroy]

  def index
    @categories = Category.all
  end

  def new
    @category = Category.new(parent_id: params[:parent_id])
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      if params[:from_post].present?
        redirect_to new_post_path
      else
        redirect_to categories_path
      end
    else
      render 'new'
    end
  end

  def destroy
    @category.destroy
    redirect_to categories_path
  end

  private

  def category_params
    params[:category].permit(:name, :parent_id)
  end

  def set_category
    @category = Category.find(params[:id])
  end
end
