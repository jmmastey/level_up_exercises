require 'active_support/all'

class BlagPost
  attr_accessor :author, :comments, :categories, :body, :publish_date

  Author = Struct.new(:name, :url)
  DISALLOWED_CATEGORIES = [:selfposts, :gossip, :bildungsromane]

  def initialize(args)

    args.symbolize_keys!

    if args[:author].present? && args[:author_url].present?
      @author = Author.new(args[:author], args[:author_url])
    end

    if args[:categories]
      @categories = args[:categories].reject do |category|
        category.in?(DISALLOWED_CATEGORIES)
      end
    else
      @categories = []
    end

    @comments = args[:comments].presence || []
    @body = args[:body].squish
    @publish_date = args[:publish_date].presence.try(:to_date) || Date.current

  end

  def to_s
    [ category_list, byline, abstract, commenters ].join("\n")
  end

  private

  def byline
    author.try {"By #{author.name}, at #{author.url}"} || ""
  end

  def category_list
    return "" if categories.empty?
    label = "Category".pluralize(categories.length)
    cats = categories.to_sentence.titleize
    "#{label}: #{cats}"
  end



  def commenters
    return '' if !comments_allowed? || comments.blank?
    "You will be the #{comments.length.ordinalize} commenter"
  end

  def comments_allowed?
    publish_date.advance(years: 3)  > Date.current
  end

  def abstract
    body.truncate(200, omission: '...')
  end

end

# Skip validation of locale
I18n.enforce_available_locales = false

blag = BlagPost.new("author"        => "Foo Bar",
                    "author_url"    => "http://www.google.com",
                    "categories"    => [:theory_of_computation, :languages, :gossip],
                    "comments"      => [ [], [], [] ], # because comments are meaningless, get it? yes...
                    "publish_date"  => "2013-02-10",
                    "body"          => <<-ARTICLE.strip_heredoc
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
