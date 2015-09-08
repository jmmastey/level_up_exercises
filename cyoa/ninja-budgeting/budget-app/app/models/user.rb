class User < ActiveRecord::Base
  has_many :terms
  has_many :categories
  has_many :funds

  def self.from_omniauth(auth)
    options = auth.slice(:provider, :uid)

    where(provider: options.provider,
          uid: options.uid).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.save!
    end
  end
end
