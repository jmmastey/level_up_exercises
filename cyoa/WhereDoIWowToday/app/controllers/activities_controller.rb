class ActivitiesController < ApplicationController
  before_action :set_activity, except: :unhide
  before_action :set_category, only: :unhide

  def add_to_goals
    @activity.list_position = next_list_position
    @activity.save
    redirect_to_zone_summary
  end

  def remove_from_goals
    @activity.list_position = nil
    @activity.save
    redirect_to_zone_summary
  end

  def hide
    @activity.hide
    redirect_to_zone_summary
  end

  def unhide
    activities = Activity.where(
      category: @category, character_id: params[:character])
    activities.each.map(&:unhide)
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

  def next_list_position
    latest_goal = latest_related_goal
    latest_position = latest_goal.nil? ? 0 : latest_goal.list_position
    latest_position + 1
  end

  def latest_related_goal
    Activity.where(
      character: @activity.character, category: @activity.category)
      .where.not(list_position: nil)
      .order(:list_position).last
  end
end
