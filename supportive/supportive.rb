# In case you missed them, here are the extensions: http://guides.rubyonrails.org/active_support_core_extensions.html

require 'active_support/all'

class BlagPost
  attr_accessor :author, :comments, :categories, :body, :publish_date

  Author = Struct.new(:name, :url)

  BANNED_CATEGORIES = [:selfposts, :gossip, :bildungsromane]

  def initialize(params)
    params.symbolize_keys!

    if params[:author].present? && params[:author_url].present?
      @author = Author.new(params[:author], params[:author_url])
    end

    if params[:categories]
      @categories = params[:categories].reject do |category|
        BANNED_CATEGORIES.include? category
      end
    else
      @categories = []
    end

    @comments = params[:comments] || []
    @body = params[:body].squish
    @publish_date = (params[:publish_date] && Date.parse(params[:publish_date])) || Date.today
  end

  def to_s
    [ category_list, byline, abstract, commenters ].join("\n")
  end

  private

  def byline
    return "" if author.nil?
    "By #{author.name}, at #{author.url}"
  end

  def category_list
    return "" if categories.empty?

    prefix = "Category".pluralize(categories.length) + ": "
    list = categories.map { |category| category.to_s.titleize }.to_sentence
    prefix + list
  end

  def commenters
    return "" unless comments_allowed? || comments.any?

    "You will be the #{comments.length}#{comments.length.ordinal} commenter"
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
                    "categories"    => [:theory_of_computation, :languages, :gossip, :another_category],
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
