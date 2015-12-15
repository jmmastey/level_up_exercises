# In case you missed them, here are the extensions: http://guides.rubyonrails.org/active_support_core_extensions.html

require 'active_support/all'

class BlagPost
  attr_accessor :author, :comments, :categories, :body, :publish_date

  Author = Struct.new(:name, :url)
  DISALLOWED_CATEGORIES = [:selfposts, :gossip, :bildungsromane]

  def initialize(args)
    args = args.transform_keys(&:to_sym)
    args = args.reverse_merge(categories: [],
                              comments: [],
                              publish_date: Date.today.to_s)

    if args[:author].present? && args[:author_url].present?
      @author = Author.new(args[:author], args[:author_url])
    end

    # in rails 5: args[:categories].without(DISALLOWED_CATEGORIES)
    @categories = args[:categories].reject do |category|
      DISALLOWED_CATEGORIES.include? category
    end
    @comments = args[:comments]
    @body = args[:body].gsub(/\s{2,}|\n/, ' ').gsub(/^\s+/, '')
    @publish_date = Date.parse(args[:publish_date])
  end

  def to_s
    [category_list, byline, abstract, commenters].join("\n")
  end

  private

  def byline
    author.try(:name) ? "By #{author.name}, at #{author.url}" : ""
  end

  def category_list
    return "" if categories.empty?

    label = "Category".pluralize(categories.length)
    label + ": " + categories.map do |category|
      category.to_s.titleize
    end.to_sentence
  end

  def commenters
    return '' unless comments_allowed?
    return '' unless comments.present?
    "You will be the #{comments.length}#{comments.length.ordinal} commenter"
  end

  def comments_allowed?
    publish_date.years_since(3) > Date.today
  end

  def abstract
    body.truncate(204)
  end
end
