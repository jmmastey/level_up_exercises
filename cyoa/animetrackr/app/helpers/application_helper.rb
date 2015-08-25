module ApplicationHelper
  def page_title(separator = ' | ')
    [content_for(:title), 'AnimeTrackr'].compact.join(separator)
  end

  def page_heading(title)
    content_for(:title) { title }
  end
end
