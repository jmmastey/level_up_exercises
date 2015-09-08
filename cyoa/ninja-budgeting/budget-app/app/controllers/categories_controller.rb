class CategoriesController < ApplicationController
  before_action :logged_in_user

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    @category.user_id = current_user.id
    if @category.save
      flash[:success] = 'Category successfully created.'
      redirect_to :back
    else
      flash[:danger] = 'Could not create category.'
      redirect_to :back
    end
  end

  def update
    @category = Category.find(params[:id])
    @category.update(name: params[:name])
    flash[:success] = 'Category successfully updated.'
    redirect_to '/categories'
  end

  def destroy
    Category.destroy(params[:id])
    flash[:success] = 'Category deleted.'
    redirect_to '/categories'
  end

  def index
    @categories = Category.where(user_id: current_user.id).order(name: :ASC)
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end

  def logged_in_user
    return if logged_in?
    flash[:danger] = 'Please log in first.'
    redirect_to root_path
  end
end
