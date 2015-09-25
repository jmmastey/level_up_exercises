class ActivitiesController < ApplicationController
  before_action :set_activity, except: :unhide
  before_action :set_category, only: :unhide

  def add_to_goals
    current_user.add_to_goals(@activity)
    redirect_to_zone_summary
  end

  def remove_from_goals
    current_user.remove_from_goals(@activity)
    redirect_to_zone_summary
  end

  def hide
    current_user.hide(@activity)
    redirect_to_zone_summary
  end

  def unhide
    character = Character.find(params[:character])
    current_user.unhide_all(
      category_id: @category.id, character_id: character.id)
    activities = Activity.where(
      category: @category, character: character) 
    @activity = activities.first
    redirect_to_zone_summary
  end

  private

  def set_activity
    @activity = Activity.find(params[:id])
  end

  def set_category
    @category = Category.find(params[:category])
  end

  def redirect_to_zone_summary
    character_param = "?character=#{@activity.character_id}"
    redirect_to(category_path(@activity.category) + character_param)
  end
end
