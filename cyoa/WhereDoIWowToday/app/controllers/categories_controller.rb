class CategoriesController < ApplicationController
  def index
    @categories = Category.all
  end

  def show
    @category = Category.find(params[:id])
    character_id = params[:character]
    @character = character_id.nil? ? nil : Character.find(character_id.to_i)
    character_activities = @category.character_activities(
      character: @character, user: current_user)
    @goals = @category.goals(character: @character, user: current_user)
    hidden_activities = OwnedActivity.hidden_activities(character: @character, category: @category, user: current_user)
    @available_activities = character_activities - @goals - hidden_activities
  end
end
