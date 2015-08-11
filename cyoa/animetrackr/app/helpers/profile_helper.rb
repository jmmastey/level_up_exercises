require 'digest'
require 'action_view'

module ProfileHelper
  include ActionView::Helpers::DateHelper

  def gravatar_for(email)
    email.downcase!
    email_digest = Digest::MD5.hexdigest(email)
    "https://www.gravatar.com/avatar/#{email_digest}".html_safe
  end

  def member_since(time)
    'Member Since: ' + time.strftime('%m-%d-%Y')
  end

  def anime_wishlist(user, limit = 0)
    wishlist = sort_by_created_date(user.library_items.select(&:wishlist?))

    return wishlist if limit == 0
    wishlist.take(limit)
  end

  def anime_currently_watching(user, limit = 0)
    c = sort_by_created_date(user.library_items.select(&:currently_watching?))

    return c if limit == 0
    c.take(limit)
  end

  def anime_done_watching(user, limit = 0)
    done = sort_by_created_date(user.library_items.select(&:done_watching?))

    return done if limit == 0
    done.take(limit)
  end

  private

  def sort_by_created_date(items)
    items.sort { |a, b| a.created_at <=> b.created_at }
  end
end
