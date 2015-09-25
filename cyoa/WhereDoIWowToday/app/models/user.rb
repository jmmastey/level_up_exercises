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
    return all_showable_goals if args.empty?
    raise_if_bad_arg(args)
    find_goals_by(args)
  end

  def available_activities(args = {})
    raise_if_bad_arg(args)
    available_owned_activities(args) + available_unowned_activities(args)
  end

  def add_to_goals(activity)
    owned = owned_activities.find_by(activity: activity)
    return OwnedActivity.create_goal(self, activity) if owned.nil?
    return if owned.goal?
    owned.convert_to_goal
  end

  def remove_from_goals(activity)
    goal = owned_activities.find_by(activity: activity)
    goal.make_not_goal
  end

  def hide(activity)
    owned = owned_activities.find_by(activity: activity)
    if owned.nil?
      return OwnedActivity.create!(activity: activity, user: self, hidden: true)
    end
    owned.hide
  end

  def unhide_all(args = {})
    owned_activities.each.map(&:unhide) if args.empty?
    raise_if_bad_arg(args)
    owneds = owned_activities.where(hidden: true)
             .includes(:activity).where(activities: args)
    owneds.map(&:unhide)
  end

  private

  def all_showable_goals
    owneds = owned_activities.where.not(index: nil)
                      .where(hidden: false)
    owneds.map(&:activity)
  end

  def raise_if_bad_arg(args)
    bad_args = args.keys - [:category_id, :character_id]
    return if bad_args.empty?
    raise ArgumentError.new("Unrecognized argument: #{bad_args}")
  end

  def find_goals_by(args)
    owneds = owned_activities.where.not(index: nil)
                      .where(hidden: false)
                      .includes(:activity).where(activities: args)
    owneds.map(&:activity)
  end

  def available_owned_activities(args)
    if args.empty?
      owneds = owned_activities.where(index: nil, hidden: false)
    else
      owneds = owned_activities.where(hidden: false, index: nil)
                   .includes(:activity).where(activities: args)
    end
    owneds.map(&:activity)
  end

  def available_unowned_activities(args)
    owned = owned_activities.map(&:activity)
    activities = Activity.where(args)
    activities - owned
  end
end
