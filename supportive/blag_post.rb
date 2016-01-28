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
    [category_list, byline, abstract, commenters].join("\n")
  end

  private

  def byline
    if author.nil?
      ""
    else
      "By #{author.name}, at #{author.url}"
    end
  end

  def category_list
    return "" if categories.empty?

    if categories.length == 1
      label = "Category"
    else
      label = "Categories"
    end

    if categories.length > 1
      last_category = categories.pop
      suffix = " and #{as_title(last_category)}"
    else
      suffix = ""
    end

    label + ": " + categories.map { |cat| as_title(cat) }.join(", ") + suffix
  end

  def as_title(string)
    string = String(string)
    words = string.gsub('_', ' ').split(' ')

    words.map!(&:capitalize)
    words.join(' ')
  end

  def commenters
    return '' unless comments_allowed?
    return '' unless comments.length > 0

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
    if body.length < 200
      body
    else
      body[0..200] + "..."
    end
  end

end
