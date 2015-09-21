class CategoriesController < ApplicationController
  def index
    @categories = Category.all
  end

  def show
    @category = Category.find(params[:id])
    @character = params[:character].nil? ? nil : params[:character].to_i
    set_quests
    set_goals
  end

  private

  def set_quests
    @quests = Activity.where(character: @character,
                             category: @category,
                             list_position: nil,
                             hidden: false)
              .map(&:quest)
              .compact
  end

  def set_goals
    @goals = Activity.where(character: @character,
                            category: @category,
                            hidden: false)
             .where.not(list_position: nil)
             .order(list_position: :asc)
  end
end
