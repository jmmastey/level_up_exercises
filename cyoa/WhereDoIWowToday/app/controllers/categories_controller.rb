class CategoriesController < ApplicationController
  before_action :set_category, only: :show
  before_action :set_categories, only: :index

  def show
    category_id = params[:id]
    character_id = params[:character]
    @character = Character.find(character_id.to_i)
    if current_user.nil?
      @goals = []
      @available_activities = @category.character_activities(@character)
    else
      @goals = current_user.goals(
        character_id: character_id, category_id: category_id)
      @available_activities = current_user.available_activities(
        character_id: character_id, category_id: category_id)
    end
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end

  def set_categories
    @categories = Category.all
  end
end
