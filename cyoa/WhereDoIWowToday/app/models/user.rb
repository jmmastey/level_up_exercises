class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise(
    :database_authenticatable, :registerable, :recoverable, :rememberable,
    :trackable, :validatable
  )

  has_many :owned_activities
  accepts_nested_attributes_for :owned_activities

  def goals(args = {})
    return all_visible_goals if args.empty?
    raise_if_bad_arg(args)
    restricted_goals(args)
  end

  def available_activities(args = {})
    if args.empty?
      return(all_visible_non_goal_activities +
             available_unowned_activities(args))
    end
    raise_if_bad_arg(args)
    available_owned_activities(args) + available_unowned_activities(args)
  end

  def add_to_goals(activity)
    owned_activity = owned_activities.find_by(activity: activity)
    if owned_activity.nil?
      return OwnedActivity.create!(
               activity: activity, user: self, index: next_goal_index)
    end
    return unless owned_activity.index.nil?
    owned_activity.index = next_goal_index
    owned_activity.save
  end

  def remove_from_goals(activity)
    owned_activity = owned_activities.find_by(activity: activity)
    # return if owned_activity.nil? || owned_activity.index.nil?
    owned_activity.index = nil
    owned_activity.save
  end

  def hide(activity)
    owned_activity = owned_activities.find_by(activity: activity)
    if owned_activity.nil?
      return OwnedActivity.create!(activity: activity, user: self, hidden: true)
    end
    owned_activity.hide
  end

  def unhide_all(args = {})
    owned_activities.each.map(&:unhide) if args.empty?
    raise_if_bad_arg(args)
    activity_containers = owned_activities.where(hidden: true)
                          .includes(:activity).where(activities: args)
    activity_containers.map(&:unhide)
  end

  def unhide(activity)
    owned_activity = owned_activities.find_by(activity: activity)
    owned_activity.unhide unless owned_activity.nil?
  end

  private

  def all_visible_goals
    goal_containers = owned_activities.where.not(index: nil)
                      .where(hidden: false)
    goal_containers.map(&:activity)
  end

  def raise_if_bad_arg(args)
    bad_args = args.keys - [:category_id, :character_id]
    unless bad_args.empty?
      raise ArgumentError.new("Unrecognized argument: #{bad_args}")
    end
  end

  def restricted_goals(args)
    goal_containers = owned_activities.where.not(index: nil)
                      .where(hidden: false)
                      .includes(:activity).where(activities: args)
    goal_containers.map(&:activity)
  end

  def available_owned_activities(args)
    activity_containers = owned_activities.where(hidden: false, index: nil)
                          .includes(:activity).where(activities: args)
    activity_containers.map(&:activity)
  end

  def all_visible_non_goal_activities
    goal_containers = owned_activities.where(index: nil, hidden: false)
    goal_containers.map(&:activity)    
  end

  def available_unowned_activities(args)
    owned = owned_activities.map(&:activity)
    activities = Activity.where(args)
    activities - owned
  end

  def next_goal_index
    goals = OwnedActivity.where(user: self).where.not(index: nil)
    return 1 if goals.empty?
    goals.map(&:index).max + 1
  end
end
