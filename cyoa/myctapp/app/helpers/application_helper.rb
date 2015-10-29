module ApplicationHelper

  # Returns full page title
  def full_title(page_title = '')
    base_title = "MyCTApp"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end
end
