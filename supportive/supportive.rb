# In case you missed them, here are the extensions: http://guides.rubyonrails.org/active_support_core_extensions.html

require 'active_support/all'

class BlagPost
  attr_accessor :author, :comments, :categories, :body, :publish_date

  Author = Struct.new(:name, :url) do
    I18n.config.enforce_available_locales = true

    def to_s
      info = []
      info << "By #{self.name}" if self.name.present?
      info << "at #{self.url}" if self.url.present?
      info.to_sentence(:two_words_connector => ", ")
    end

  end
  DISALLOWED_CATEGORIES = [:selfposts, :gossip, :bildungsromane]

  def initialize(args)
    args.symbolize_keys!

    @author = Author.new(args[:author].presence, args[:author_url].presence)
    @categories = (args[:categories] || []).reject { |category| category.in? DISALLOWED_CATEGORIES }
    @comments = args[:comments] || []
    @body = args[:body].squish
    @publish_date = (args[:publish_date] || Date.current).to_date
  end

  def to_s #to_query
    [category_list, author.to_s, body.truncate(200), commenters].join("\n")
  end

  private

  def category_list
    return "" if categories.empty?
    label = "Category".pluralize(categories.length) + ": "
    suffix = " and #{categories.pop.to_s.titleize}" if categories.length > 1 || ''.to_s
    label + categories(&:to_s).join(", ").titleize + suffix
  end

  def commenters
    return '' unless comments_allowed? && comments.length > 0
    "You will be the #{comments.length.ordinalize} commenter"
  end

  def comments_allowed?
    publish_date.years_since(3) > Date.current
  end

end

blag = BlagPost.new("author" => "Foo Bar",
                    "author_url" => "http://www.google.com",
                    "categories" => [:theory_of_computation, :languages, :gossip],
                    "comments" => [],
                    "publish_date" => "2013-02-10",
                    "body" => <<-ARTICLE
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