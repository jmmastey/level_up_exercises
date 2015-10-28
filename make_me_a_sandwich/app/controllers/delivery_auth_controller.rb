class DeliveryAuthController < ApplicationController
  def authorize
    redirect_to authorize_uri
  end

  def callback
    result = LoginUser.call(client: delivery_client, auth_code: params[:code])
    if result.success?
      login_user(result)
      flash[:notice] = "You have been signed in successfully."
      redirect_to root_path
    else
      flash[:error] = result.errors.first.try(:[], "user_msg")
      render status: 400
    end
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

  def login_user(context)
    session[:access_key] = context.access_key
    session[:expires] = Time.at(context.expires)
    session[:user_id] = context.user.id
  end
end
