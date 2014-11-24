class PageContent < ActiveRecord::Base
  validates_length_of :content, maximum: 1500
  validates_length_of :html, maximum: 3000
  before_save :render_html
  after_initialize :init

  def init
    self.content ||= ''
  end

  def to_s
    String(html).html_safe
  end

  private

  def render_html
    self.html = renderer.render(content)
  end

  def renderer
    Redcarpet::Markdown.new(
      Redcarpet::Render::HTML.new(escape_html: true),
      autolink: true, tables: true,
    )
  end
end
