class OwnedActivity < ActiveRecord::Base
  belongs_to :activity
  belongs_to :user
    
  def self.create_goal(user, activity)
    index = next_index(user.owned_activities)
    create(user:user, activity: activity, index: index)
  end

  def self.next_index(owned_activities)
    existing_indices = owned_activities.map(&:index).compact
    return 1 if existing_indices.empty?
    existing_indices.max + 1
  end

  def showable?
    !hidden
  end

  def goal?
    !index.nil?
  end

  def hide
    self.hidden = true
    save
  end

  def unhide
    self.hidden = false
    save
  end

  def make_not_goal
    self.index = nil
    save
  end

  def convert_to_goal
    index = self.class.next_index(OwnedActivity.where(user: user))
    self.index = index
    save
  end
end
