class CategoriesController < ApplicationController
  before_action :set_category, only: :show
  before_action :set_categories, only: :index

  def show
    @character = Character.find(params[:character])
    set_goals
    set_available_activities
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end

  def set_categories
    @categories = Category.all
  end

  def set_goals
    if current_user.nil?
      @goals = []
    else
      @goals = current_user.goals(
        character_id: @character.id, category_id: @category.id)
    end
  end

  def set_available_activities
    if current_user.nil?
      @available_activities = @category.character_activities(@character)
    else
      @available_activities = current_user.available_activities(
        character_id: @character.id, category_id: @category.id)
    end
  end
end
