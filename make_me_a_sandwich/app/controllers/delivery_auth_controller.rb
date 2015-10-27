class DeliveryAuthController < ApplicationController
  def authorize
    redirect_to authorize_uri
  end

  def callback
  end

  private

  def authorize_params
    {
      client_id: ENV["DELIVERY_API_KEY"],
      client_secret: ENV["DELIVERY_API_SECRET"],
      redirect_uri: delivery_auth_callback_url,
      response_type: :code,
      scope: :global,
    }
  end

  def authorize_uri
    uri = URI.join(AppConfig.delivery.site, AppConfig.delivery.path.authorize)
    uri.query = authorize_params.to_query
    uri.to_s
  end
end
