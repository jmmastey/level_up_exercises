module ApplicationHelper

  def markdown(text)
    renderer = Redcarpet::Markdown.new(Redcarpet::Render::HTML.new(render_options = {escape_html: true}))
    renderer.render(text).html_safe
  end
end
