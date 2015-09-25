class CategoriesController < ApplicationController
  def index
    @categories = Category.all
  end

  def show
    category_id = params[:id]
    @category = Category.find(category_id)
    character_id = params[:character]
    @character = character_id.nil? ? nil : Character.find(character_id.to_i)
    if current_user.nil?
      @goals = []
      @available_activities = @category.character_activities(@character)
    else
      @goals = current_user.goals(character_id: character_id, category_id: category_id)
      @available_activities = current_user.available_activities(
        character_id: character_id, category_id: category_id)
    end
  end
end
