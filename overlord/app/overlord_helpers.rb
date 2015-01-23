module OverlordHelpers
  def start_time
    session[:start_time] ||= (Time.now).to_s
  end

  def base_url
    @base_url ||= "#{request.env['rack.url_scheme']}://#{request.env['HTTP_HOST']}"
  end
end