class LibraryItem < ActiveRecord::Base
  belongs_to :user
  belongs_to :anime

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
end
