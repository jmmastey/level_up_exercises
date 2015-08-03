module ApplicationHelper
  def full_title(page_title)
    base_title = "MTG Deck Builder"
    if page_title.empty?
      base_title
    else
      "#{page_title} | #{base_title}"
    end
  end
end
