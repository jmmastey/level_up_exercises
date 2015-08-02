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
end
