class OwnedActivity < ActiveRecord::Base
  belongs_to :activity
  belongs_to :user

  def self.hide(activity: activity, user: user)
    goal = find_or_create(activity: activity, user: user)
    goal.hidden = true
    goal.save
  end

  def self.unhide(character:, user:, category:)
    OwnedActivity.where(user: user).each do |owned_activity|
      if owned_activity.activity.character == character &&
         owned_activity.activity.category == category
        owned_activity.hidden = false
        owned_activity.save
      end
    end
  end

  def self.remove_from_goals(activity:, user:)
    return if activity.nil? || user.nil?
    goal = OwnedActivity.find_by(activity: activity, user: user)
    return if goal.nil? || goal.list_position.nil?
    goal.list_position = nil
    goal.save
  end

  def self.add_to_goals(activity:, user:)
    return if activity.nil? || user.nil?
    goal = find_or_create(activity: activity, user: user)
    return unless goal.list_position.nil?
    high_position = highest_list_position(
      character: activity.character, user: user, category: activity.category)
    new_position = high_position + 1
    goal.list_position = new_position
    goal.save
  end

  def self.goals(character:, user:, category:)
    owned_activities = OwnedActivity.where(user: user, hidden: false)
                       .where.not(list_position: nil)
                       .order(:list_position)
    activities = owned_activities.map(&:activity)
    activities.select do |activity|
      activity.category == category && activity.character == character
    end
  end

  def self.hidden_activities(character:, user:, category:)
    owned_activities = OwnedActivity.where(user: user, hidden: true)
    activities = owned_activities.map(&:activity)
    activities.select do |activity|
      activity.category == category && activity.character == character
    end
  end

  def self.find_or_create(args)
    OwnedActivity.find_by(args) || OwnedActivity.create!(args)
  end
  private_class_method :find_or_create

  def self.highest_list_position(character:, user:, category:)
    return 0 if character.nil? || user.nil? || category.nil?
    owned_activities = OwnedActivity.where(user: user, hidden: false)
                       .where.not(list_position: nil)
                       .order(:list_position)
    return 0 if owned_activities.empty?
    owned_activities.last.list_position
  end
  private_class_method :highest_list_position
end
