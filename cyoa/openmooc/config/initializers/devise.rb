Devise.setup do |config|
  config.secret_key = ENV['DEVISE_SECRET_KEY']
  config.mailer_sender = 'moocipedia@no-reply.com'

  require 'devise/orm/active_record'

  config.case_insensitive_keys = [:email]
  config.strip_whitespace_keys = [:email]
  config.skip_session_storage = [:http_auth]
  config.stretches = Rails.env.test? ? 1 : 10
  config.confirm_within = 2.days

  config.reconfirmable = false
  config.expire_all_remember_me_on_sign_out = true
  config.password_length = 8..128

  # config.email_regexp = /\A[^@]+@[^@]+\z/

  config.reset_password_within = 6.hours
  config.scoped_views = true
  config.default_scope = :user
  config.sign_out_via = :delete
end
