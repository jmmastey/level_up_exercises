# In case you missed them, here are the extensions: http://guides.rubyonrails.org/active_support_core_extensions.html

require 'active_support/all'

class BlagPost
  attr_accessor :author, :comments, :categories, :body, :publish_date

  Author = Struct.new(:name, :url)
  DISALLOWED_CATEGORIES = [:selfposts, :gossip, :bildungsromane]

  def initialize(args)
    @document = args.symbolize_keys
    extract_author
    extract_categories
    extract_comments
    extract_body
    set_publish_date
  end

  def to_s
    [category_list, by_line, abstract, commenters].reject(&:blank?).join("\n")
  end

  private

  def extract_author
    return unless @document[:author].present? && @document[:author_url].present?
    @author = Author.new(@document[:author], @document[:author_url])
  end

  def extract_categories
    return unless @document[:categories].present?
    @categories = @document[:categories].reject {|cat| cat.in?(DISALLOWED_CATEGORIES) }
  end

  def extract_comments
    @comments = @document[:comments].presence
  end

  def extract_body
    @body = @document[:body].squish
  end

  def set_publish_date
    @publish_date = (@document[:publish_date].try { |date| Date.parse(date) }) || Date.today
  end

  def by_line
    author.try { |a| "By #{a.name}, at #{a.url}" }
  end

  def category_list
    return "" unless categories.present?
    label = "Category".pluralize(categories.size)
    label + ": " + categories.map { |cat| String(cat).titleize }.to_sentence
  end

  def commenters
    return '' unless comments_allowed?
    return '' unless comments.present?
    "You will be the #{comments.length.ordinalize} commenter"
  end

  def comments_allowed?
    publish_date.years_since(3) > Date.today
  end

  def abstract
    body.truncate(204)
  end
end

blag = BlagPost.new("author"        => "Foo Bar",
                    "author_url"    => "http://www.google.com",
                    "categories"    => [:theory_of_computation, :languages, :gossip],
                    "comments"      => [ [], [], [] ], # because comments are meaningless, get it?
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
puts blag
