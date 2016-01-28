# In case you missed them, here are the extensions: http://guides.rubyonrails.org/active_support_core_extensions.html

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

    @publish_date = pub_date ? pub_date : Date.today
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

    label = "Category"
    label = label.pluralize if categories.length > 1
    label + ": " + categories.map { |cat| as_title(cat) }.to_sentence
  end

  def as_title(string)
    string = String(string)
    words = string.gsub('_', ' ').split(' ')

    words.map!(&:capitalize)
    words.join(' ')
  end

  def commenters
    return nil unless comments_allowed?
    return nil unless comments.length > 0

    ordinal = case comments.length % 10
      when 1 then "st"
      when 2 then "nd"
      when 3 then "rd"
      else "th"
    end
    "You will be the #{comments.length}#{ordinal} commenter"
  end

  def comments_allowed?
    publish_date + (365 * 3) > Date.today
  end

  def abstract
    if body
      if body.length < 200
        body
      else
        body[0..200] + "..."
      end
    end
  end
end
