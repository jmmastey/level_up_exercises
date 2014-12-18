module ApplicationHelper

  def markdown(text)
    renderer = Redcarpet::Markdown.new(Redcarpet::Render::HTML.new())
    renderer.render(text).html_safe
  end
end
