require_relative '../blag_post.rb'

describe BlagPost do
  author_name = "Foo Bar"
  author_url = "http://www.google.com"
  categories = [:theory_of_computation, :languages, :gossip]
  comments = [[], [], []]
  publish_date = "2013-02-10"
  body = "FOOBAR"
  body_with_spaces = "Buffalo  buffalo    Buffalo buffalo      buffalo\n"\
    " buffalo\nBuffalo      buffalo "

  context "when creating a new BlagPost with all parameters" do
    before(:each) do
      @blagpost = BlagPost.new(
        author: author_name,
        author_url: author_url,
        categories: categories,
        comments: comments,
        publish_date: publish_date,
        body: body,
      )
    end

    describe "#new" do
      it "has struct with @author_name" do
        expect(@blagpost.author.name).to eq author_name
      end

      it "has struct with with @author_url" do
        expect(@blagpost.author.url).to eq author_url
      end

      it "has categories containing allowed categories" do
        expect(@blagpost.categories).to eq [:theory_of_computation, :languages]
      end

      it "has @comments" do
        expect(@blagpost.comments).to eq comments
      end

      it "has a parsed publish date" do
        expect(@blagpost.publish_date).to eq Date.parse(publish_date)
      end

      it "has a @body" do
        expect(@blagpost.body).to eq body
      end
    end

    describe "#to_s" do
      it "returns expected formatted string" do
        formatted_string = ["Categories: Theory Of Computation and Languages",
                            "By Foo Bar, at http://www.google.com",
                            "FOOBAR",
                            "You will be the 3rd commenter"].join("\n")

        expect(@blagpost.to_s).to eq formatted_string
      end
    end
  end

  context "when creating a new BlagPost without an author_name" do
    blagpost = BlagPost.new(
      author_url: author_url,
      categories: categories,
      comments: comments,
    )

    it "does contains an author struct without a name" do
      expect(blagpost.author.name).to be_nil
    end

    it "does contain an author struct with a url" do
      expect(blagpost.author.url).to eq author_url
    end
  end

  describe "#new" do
    context "when creating a new BlagPost without params" do
      before(:each) do
        @blagpost = BlagPost.new
      end

      it "returns a new BlagPost object" do
        expect(@blagpost).to be_a(BlagPost)
      end

      it "does not contain an author struct" do
        expect(@blagpost.author).to be_nil
      end

      it "contains an empty category array" do
        expect(@blagpost.categories).to eq []
      end

      it "contains an empty category array" do
        expect(@blagpost.comments).to eq []
      end
    end

    context "when creating a new BlagPost without allowed categories" do
      it "contains an empty category array" do
        blagpost = BlagPost.new(categories: [:gossip])
        expect(blagpost.categories).to eq []
      end
    end

    context "when creating a new BlagPost with weird body spacing" do
      it "parses the body and fixes the spaced formatting" do
        blagpost = BlagPost.new(body: body_with_spaces)
        expect(blagpost.body).to eq "Buffalo buffalo Buffalo buffalo buffalo "\
          "buffalo Buffalo buffalo"
      end
    end

    context "when creating a new BlagPost with a bad date" do
      it "assigns Date.today to publish_date when date is empty string" do
        blagpost = BlagPost.new(publish_date: '')

        expect(blagpost.publish_date).to eq Date.today
      end

      it "Date.today is assigned to publish_date when date is bad format" do
        blagpost = BlagPost.new(publish_date: 'asdf')
        expect(blagpost.publish_date).to eq Date.today
      end

      it "Date.today is assigned when publish_date is missing" do
        blagpost = BlagPost.new(categories: [:gossip])
        expect(blagpost.publish_date).to eq Date.today
      end
    end

    context "when creating a new BlagPost with no body parameter" do
      it "assigns nil to body" do
        blagpost = BlagPost.new(categories: [:gossip])
        expect(blagpost.body).to be_nil
      end
    end
  end
end
