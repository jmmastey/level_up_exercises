module OverlordHelpers
  def start_time
    session[:start_time] ||= (Time.now).to_s
  end
end