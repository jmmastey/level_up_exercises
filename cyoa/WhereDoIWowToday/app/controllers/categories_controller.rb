class CategoriesController < ApplicationController
  def index
    @categories = Category.all
  end

  def show
    @category = Category.find(params[:id])
    character = params[:character].nil? ? nil : params[:character].to_i
    @quests = @category.character_quests(character)
  end
end
