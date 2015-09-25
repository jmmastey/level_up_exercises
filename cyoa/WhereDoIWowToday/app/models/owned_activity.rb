class OwnedActivity < ActiveRecord::Base
  belongs_to :activity
  belongs_to :user

  def hide
    self.hidden = true
    self.save
  end

  def unhide
    self.hidden = false
    self.save
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
