class ActivitiesController < ApplicationController
  before_action :set_activity, except: :unhide
  before_action :set_category, only: :unhide

  def add_to_goals
    OwnedActivity.add_to_goals(activity: @activity, user: current_user)
    redirect_to_zone_summary
  end

  def remove_from_goals
    OwnedActivity.remove_from_goals(activity: @activity, user: current_user)
    redirect_to_zone_summary
  end

  def hide
    OwnedActivity.hide(activity: @activity, user: current_user)
    redirect_to_zone_summary
  end

  def unhide
    character = Character.find(params[:character])
    OwnedActivity.unhide(
      category: @category, character: character, user: current_user)
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
