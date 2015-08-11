class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def after_sign_in_path_for(resource)
    request.env['omniauth.origin'] || stored_location_for(resource) || root_path
  end

  def ensure_nonempty_query
    @search_params = query_params[:query].to_s.strip
    render(layout: false) && return if @search_params.empty?
  end

  private

  def query_params
    params.permit(:query)
  end
end
