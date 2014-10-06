# In case you missed them, here are the extensions: http://guides.rubyonrails.org/active_support_core_extensions.html

require 'active_support/all'

class BlagPost
  attr_accessor :author, :comments, :categories, :body, :publish_date

  Author = Struct.new(:name, :url)
  DISALLOWED_CATEGORIES = [:selfposts, :gossip, :bildungsromane]

  def initialize(args)
    args = args.inject({}) do |hash, (key, value)|
      hash[key.to_sym] = value
      hash
    end
    set_author_presence(args)
    @categories = category_filter(args)
    set_blag_info(args)
  end

  def set_blag_info(args)
    @comments = args[:comments] || []
    @body = args[:body].gsub(/\s{2,}|\n/, ' ').gsub(/^\s+/, '')
    @publish_date = (args[:publish_date] && Date.parse(args[:publish_date])) || Date.today
  end

  def set_author_presence(args)
    if args[:author] != '' && args[:author_url] != ''
      @author = Author.new(args[:author], args[:author_url])
    end
  end
  
  def category_filter(args)
    if args[:categories]
        args[:categories].reject do |category|
        DISALLOWED_CATEGORIES.include? category ||= []
      end
    end
  end

  def to_s
    [ category_list, byline, abstract, commenters ].join("\n")
  end

  private

  def byline
    return "" unless author
    "By #{author.name}, at #{author.url}"
  end

  def category_list
    return "" if categories.empty?
    label = categories.length == 1 ? "Category" : "Categories"
    label + ": " +  (categories.map { |cat| as_title(cat) }).to_sentence
  end  

  def as_title(string)
    string = String(string)
    words = string.titleize
  end

  def commenters
    return '' unless comments_allowed? || comments.length > 0    
    ordinal = comments.length.ordinalize
    "You will be the #{ordinal} commenter"
  end

  def comments_allowed?
    publish_date.years_since(3) > Date.today
  end

  def abstract
    body.truncate(200, omission: '...')
  end

end

blag = BlagPost.new("author"        => "Foo Bar",
                    "author_url"    => "http://www.google.com",
                    "categories"    => [:theory_of_computation, :languages, :gossip, :fashion, :editorial],
                    "comments"      => [ [], [], [], [] ], # because comments are meaningless, get it? ;)
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
