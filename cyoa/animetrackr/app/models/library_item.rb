class LibraryItem < ActiveRecord::Base
  belongs_to :user
  belongs_to :anime

  before_save :add_to_activity_feed

  VIEW_STATUSES = ["Wishlist", "Currently Watching", "Done"]

  validates :user_rating,
    presence: true,
    inclusion: { in: 0..5 }

  validates :view_status,
    presence: true,
    inclusion: { in: VIEW_STATUSES }

  def wishlist?
    view_status.eql?('Wishlist')
  end

  def currently_watching?
    view_status.eql?('Currently Watching')
  end

  def done_watching?
    view_status.eql?('Done')
  end

  protected

  def add_to_activity_feed
    return unless new_record? || changed?
    return create_activity("Added #{anime.title}", 'Added') if new_record?

    if view_status_changed?
      activity = "Currently watching #{anime.title}" if currently_watching?
      activity = "Done watching #{anime.title}" if done_watching?
      activity = "Added #{anime.title} to wishlist" if wishlist?
    else
      activity = "Updated rating of #{anime.title} to #{user_rating}"
    end

    create_activity(activity, 'Updated')
  end

  def create_activity(activity, state)
    Activity.create(user: user, anime: anime, activity: activity, state: state)
  end
end
