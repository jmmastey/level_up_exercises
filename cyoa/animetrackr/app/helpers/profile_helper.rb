require 'digest'

module ProfileHelper
  def gravatar_for(email)
    email.downcase!
    email_digest = Digest::MD5.hexdigest(email)
    "<img src='http://www.gravatar.com/avatar/#{email_digest}' />".html_safe
  end
end
