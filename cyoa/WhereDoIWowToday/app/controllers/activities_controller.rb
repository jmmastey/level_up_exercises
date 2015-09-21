class ActivitiesController < ApplicationController
  def show
    @activity = Activity.find(params[:id])
  end

  def add_to_goals
    activity = Activity.find(params[:id])
    latest_goal = Activity.where(
      character: activity.character, category: activity.category)
                  .where.not(list_position: nil)
                  .order(:list_position).last
    latest_position = latest_goal.nil? ? 0 : latest_goal.list_position
    activity.list_position = latest_position + 1
    activity.save
    #binding.pry
    redirect_to(category_path(activity.category) + "?character=#{activity.character_id}")
  end
end
