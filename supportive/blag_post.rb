require 'active_support/all'

class BlagPost
  attr_accessor :author, :comments, :categories, :body, :publish_date

  DISALLOWED_CATEGORIES = [:selfposts, :gossip, :bildungsromane]
  Author = Struct.new(:name, :url)

  def categories=(categories)
    categories = categories.presence || []

    @categories = categories.reject do |category|
      DISALLOWED_CATEGORIES.include? category
    end
  end

  def body=(body)
    @body = body.gsub(/\s{2,}|\n/, ' ').gsub(/^\s+|\s+$/, '') if body.presence
  end

  def publish_date=(pub_date)
    pub_date = pub_date.presence || ''

    begin
      pub_date = pub_date.to_date
    rescue ArgumentError
      pub_date = nil
    end

    @publish_date = pub_date ? pub_date : Date.current
  end

  def initialize(args = {})
    unless args[:author].blank? && args[:author_url].blank?
      @author = Author.new(args[:author], args[:author_url])
    end

    @comments = args[:comments].presence || []
    self.categories = args[:categories]
    self.body = args[:body]
    self.publish_date = args[:publish_date]
  end

  def to_s
    [category_list, byline, abstract, commenters].reject(&:!).join("\n")
  end

  private

  def byline
    return nil unless author

    by_line = author.name.presence || 'anonymous'
    by_line += ", at #{author.url}" if author.url

    "By #{by_line}"
  end

  def category_list
    return nil if categories.empty?

    label = "Category".pluralize(categories.length) + ': '
    label + categories.map { |cat| cat.to_s.humanize.titleize }.to_sentence
  end

  def commenters
    return nil unless comments_allowed?

    comment_number = comments.length + 1

    "You will be the #{comment_number.ordinalize} commenter"
  end

  def comments_allowed?
    publish_date.years_since(3) > Date.current
  end

  def abstract
    body.truncate(200) if body
  end
end
