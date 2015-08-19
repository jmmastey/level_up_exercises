# In case you missed them, here are the extensions: http://guides.rubyonrails.org/active_support_core_extensions.html

require 'active_support/all'

class BlagPost
  attr_accessor :author, :comments, :categories, :body, :publish_date

  Author = Struct.new(:name, :url)
  DISALLOWED_CATEGORIES = [:selfposts, :gossip, :bildungsromane]

  def initialize(args)
    args = args.with_indifferent_access
    @author = setup_author(args[:author], args[:author_url])
    @categories = setup_categories(args[:categories])
    @comments = Array.wrap(args[:comments])
    @body = args[:body].squish
    @publish_date = args[:publish_date].try(&:to_date) || Date.today
  end

  def to_s
    [category_list, byline, abstract, commenters].reject(&:blank?).join("\n")
  end

  private

  def setup_author(author, url)
    Author.new(author, url) if author.present? && url.present?
  end

  def setup_categories(categories)
    return [] if categories.blank?
    categories.reject { |category| category.in? DISALLOWED_CATEGORIES }
  end

  def byline
    return if author.blank?
    "By #{author.name}, at #{author.url}"
  end

  def category_list
    return if categories.empty?
    label = 'Category'.pluralize(categories.length)
    titles = categories.map { |category| as_title(category) }
    label + ": " + titles.to_sentence
  end

  def as_title(string)
    String(string).humanize.titleize
  end

  def commenters
    return unless comments_allowed? && comments.present?
    "You will be the #{comments.length.ordinalize} commenter"
  end

  def comments_allowed?
    publish_date > 3.years.ago
  end

  def abstract
    body.truncate(200)
  end

end

blag = BlagPost.new("author"        => "Foo Bar",
                    "author_url"    => "http://www.google.com",
                    "categories"    => [:theory_of_computation, :languages, :gossip],
                    "comments"      => nil, # because comments are meaningless, get it?
                    "publish_date"  => "2013-02-10",
                    "body"          => <<-ARTICLE
                        Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec a diam lectus.
                        Sed sit amet ipsum mauris. Maecenas congue ligula ac quam viverra nec consectetur ante hendrerit.
                        Donec et mollis dolor. Praesent et diam eget libero egestas mattis sit amet vitae augue. Nam
                        tincidunt congue enim, ut porta lorem lacinia consectetur. Donec ut libero sed arcu vehicula
                        ultricies a non tortor. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean ut
                        gravida lorem. Ut turpis felis, pulvinar a semper sed, adipiscing id dolor. Pellentesque auctor
                        nisi id magna consequat sagittis. Curabitur dapibus enim sit amet elit pharetra tincidunt feugiat
                        nisl imperdiet. Ut convallis libero in urna ultrices accumsan. Donec sed odio eros. Donec viverra
                        mi quis quam pulvinar at malesuada arcu rhoncus. Cum sociis natoque penatibus et magnis dis
                        parturient montes, nascetur ridiculus mus. In rutrum accumsan ultricies. Mauris vitae nisi at sem
                        facilisis semper ac in est.
                        ARTICLE
                   )
puts blag.to_s
