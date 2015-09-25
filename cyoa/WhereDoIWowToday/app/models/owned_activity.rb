class OwnedActivity < ActiveRecord::Base
  belongs_to :activity
  belongs_to :user

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
end
