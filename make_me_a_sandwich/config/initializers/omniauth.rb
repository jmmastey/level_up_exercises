require_relative "../../lib/omniauth/delivery_sandbox"

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :delivery_sandbox, ENV['DELIVERY_API_KEY'], ENV['DELIVERY_API_SECRET']
end
