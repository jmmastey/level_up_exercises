class DeliveryAuthController < ApplicationController
  STATIC_AUTH_PARAMS = {
    client_id: ENV["DELIVERY_API_KEY"],
    client_secret: ENV["DELIVERY_API_SECRET"],
    redirect_uri: delivery_auth_callback_url,
    response_type: :code,
    scope: :global,
  }

  before_action :delivery_login_user, only: [:callback]

  def authorize
    redirect_to authorize_uri
  end

  def callback
    if @result.success?
      callback_success
    else
      callback_fail
    end
  end

  private

  def authorize_params
    STATIC_AUTH_PARAMS.merge(state: Time.now.utc.to_s)
  end

  def authorize_uri
    uri = URI.join(AppConfig.delivery.site, AppConfig.delivery.path.authorize)
    uri.query = authorize_params.to_query
    uri.to_s
  end

  def callback_success
    login_user
    redirect_to root_path
  end

  def callback_fail
    flash[:alert] = @result.errors.first.try(:[], "user_msg")
    log_errors
    redirect_to error_session_path
  end

  def delivery_login_user
    @result = DeliveryLoginUser.call(client: delivery_client,
                                     auth_code: params[:code])
  end

  def login_user
    session[:access_key] = @result.access_key
    session[:expires] = Time.at(@result.expires)
    session[:user_id] = @result.user.id
    flash[:notice] = "You have been signed in successfully."
  end

  def log_errors
    @result.errors.each { |error| Rails.logger.error(error) }
  end
end
