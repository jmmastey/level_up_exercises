class ActivitiesController < ApplicationController
  before_action :set_activity, except: :unhide

  def add_to_goals
    @activity.list_position = next_list_position
    @activity.save
    character_param = "?character=#{@activity.character_id}"
    redirect_to(category_path(@activity.category) + character_param)
  end

  def remove_from_goals
    @activity.list_position = nil
    @activity.save
    character_param = "?character=#{@activity.character_id}"
    redirect_to(category_path(@activity.category) + character_param)
  end

  def hide
    @activity.hidden = true
    @activity.save
    character_param = "?character=#{@activity.character_id}"
    redirect_to(category_path(@activity.category) + character_param)
  end

  def unhide
    character_id = params[:character]
    category_id = params[:category]
    activities = Activity.where(
      category_id: category_id, character_id: character_id)
    activities.each do |activity|
      activity.hidden = false
      activity.save
    end
    character_param = "?character=#{character_id}"
    redirect_to(category_path(Category.find(category_id)) + character_param)
  end

  private

  def set_activity
    @activity = Activity.find(params[:id])
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
