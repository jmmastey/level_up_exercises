module ApplicationHelper
  def full_title(page_title = "")
    base_title = "Lunchy"
    if page_title.empty?
      base_title
    else
      "#{base_title} - #{page_title}"
    end
  end

  def logged_in_user
    return if logged_in?
    flash[:danger] = "You must be logged in to view this page."
    redirect_to login_url
  end

  def logged_out_user
    redirect_to root_url if logged_in?
  end
end
