module AnimeLibraryHelper
  def ratings_options
    (0..5).each_with_object([]) { |i, ratings| ratings << [i, i] }
  end

  def gravatar_for(email)
    email.downcase!
    email_digest = Digest::MD5.hexdigest(email)
    "https://www.gravatar.com/avatar/#{email_digest}".html_safe
  end
end
