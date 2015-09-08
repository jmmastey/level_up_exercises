OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, ENV["NINJA_BUDGETING_CLIENT_ID"], ENV["NINJA_BUDGETING_CLIENT_SECRET"]
end