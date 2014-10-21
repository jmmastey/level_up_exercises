require 'active_support/all'

class BlagPost
  attr_accessor :author, :comments, :categories, :body, :publish_date

  Author = Struct.new(:name, :url)
  DISALLOWED_CATEGORIES = [:selfposts, :gossip, :bildungsromane]

  def initialize(args)
    args = args.inject({}) do |hash, (key, value)|
      hash.merge( { hash[key.to_sym] => value } )
      hash
    end

    if !(args[:author].blank? && args[:author_url].blank?)
      @author = Author.new(args[:author], args[:author_url])
    end

    if args[:categories].present?
      @categories = args[:categories]
      @categories.reject{ |category|  DISALLOWED_CATEGORIES.include? category }
    else
      @categories = []
    end

    @comments = args[:comments].prescence || []
    @body = args[:body].squish
    if args[:publish_date].present?
      @publish_date = Date.parse(args[:publish_date])
    else
      @publish_date =  Date.today
    end
  end

  def to_s
    [ category_list, byline, abstract, commenters ].join("\n")
  end

  private

  def byline
    author.try{ |author| "By #{author.name}, at #{author.url}" }
  end

  def category_list
    return "" if categories.empty?

    if categories.length == 1
      label.singularlize
    else
      label.plularalize
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
    words = string.to_s.gsub('_', ' ').split(' ')
    words.map!(|word| word.capitalize)
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
    date = Date.new(publish_date)
    date.years_since(3) > Date.today
  end

  def abstract
  	body.truncate(200) unless body.length < 200
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
puts blag.to_s
