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
  long_body = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec "\
              "dolor nisi, suscipit et nisl et, volutpat fermentum lorem. Sed "\
              "turpis magna, gravida et sollicitudin sed, accumsan vitae justo"\
              ". Fusce arcu magna, pharetra cursus quam nec, scelerisque "\
              "blandit purus. Integer varius, ipsum vel interdum suscipit, "\
              "eros eros posuere leo, non venenatis nisi velit sed dolor. "\
              "Mauris posuere, magna vitae mollis hendrerit, dolor elit "\
              "pellentesque ante, at vulputate neque lorem sed lorem. Ut vel "\
              "lorem imperdiet, scelerisque dui eget, faucibus purus. Praesent"\
              " nunc lacus, facilisis non finibus eget, pharetra ac risus. Nam"\
              " quis sem mattis, volutpat justo id, lobortis leo. Curabitur "\
              "condimentum, elit a sagittis consequat, magna tortor hendrerit "\
              "leo, vitae sagittis quam nunc a neque. Curabitur molestie "\
              "mauris id sapien auctor dapibus. Donec bibendum nec risus nec "\
              "vestibulum. Curabitur eget erat dictum, lobortis tortor id, "\
              "aliquet justo. Vestibulum in nisl posuere, mattis ipsum quis, "\
              "molestie tortor. Donec suscipit massa vitae neque efficitur "\
              "ultricies. Mauris consectetur at sem in pharetra."

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
                            "You will be the 4th commenter"].join("\n")

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
      it "assigns Date.current to publish_date when date is empty string" do
        blagpost = BlagPost.new(publish_date: '')

        expect(blagpost.publish_date).to eq Date.current
      end

      it "Date.current is assigned to publish_date when date is bad format" do
        blagpost = BlagPost.new(publish_date: 'asdf')
        expect(blagpost.publish_date).to eq Date.current
      end

      it "Date.current is assigned when publish_date is missing" do
        blagpost = BlagPost.new(categories: [:gossip])
        expect(blagpost.publish_date).to eq Date.current
      end
    end

    context "when creating a new BlagPost with no body parameter" do
      it "assigns nil to body" do
        blagpost = BlagPost.new(categories: [:gossip])
        expect(blagpost.body).to be_nil
      end
    end
  end

  describe "#to_s" do
    context "when creating a new BlagPost with only author info" do
      it "will return a string with author info" do
        blagpost = BlagPost.new(
          author: author_name,
          author_url: author_url,
        )
        expect(blagpost.to_s).to eq(
          "By #{author_name}, at #{author_url}\nYou will be the 1st commenter"
        )
      end
    end

    context "when creating a new BlagPost with author name" do
      it "will return a string with author name" do
        blagpost = BlagPost.new(author: author_name)
        expect(blagpost.to_s).to eq(
          "By #{author_name}\nYou will be the 1st commenter"
        )
      end
    end

    context "when creating a new BlagPost with author url" do
      it "will return a string with author url" do
        blagpost = BlagPost.new(author_url: author_url)
        puts blagpost.author.name
        expect(blagpost.to_s).to eq(
          "By anonymous, at #{author_url}\nYou will be the 1st commenter"
        )
      end
    end

    context "when creating a new BlagPost with only categories" do
      it "will return a string with category info" do
        blagpost = BlagPost.new(categories: [:foobar])
        expect(blagpost.to_s).to eq(
          "Category: Foobar\nYou will be the 1st commenter"
        )
      end
    end

    context "when creating a new BlagPost with multiple categories" do
      it "will return a string with plural categories word" do
        blagpost = BlagPost.new(categories: [:foobar, :barbaz])
        expect(blagpost.to_s).to eq(
          "Categories: Foobar and Barbaz\nYou will be the 1st commenter"
        )
      end
    end

    context "when creating a new BlagPost with only body" do
      it "will return a string with body" do
        blagpost = BlagPost.new(body: body)
        expect(blagpost.to_s).to eq(
          "FOOBAR\nYou will be the 1st commenter"
        )
      end
    end

    context "when creating a new BlagPost with only comments" do
      it "will return a string with comment info" do
        blagpost = BlagPost.new(comments: comments)
        expect(blagpost.to_s).to eq "You will be the 4th commenter"
      end
    end

    context "when creating a new BlagPost with no comments" do
      it "will return a string with 1st comment info" do
        blagpost = BlagPost.new
        expect(blagpost.to_s).to eq "You will be the 1st commenter"
      end
    end

    context "when creating a new BlagPost with a lengthy body" do
      it "will return truncated body text" do
        blagpost = BlagPost.new(body: long_body)
        expect(blagpost.to_s).to eq "Lorem ipsum dolor sit amet, consectetur "\
                                    "adipiscing elit. Donec dolor nisi, "\
                                    "suscipit et nisl et, volutpat fermentum "\
                                    "lorem. Sed turpis magna, gravida et "\
                                    "sollicitudin sed, accumsan vitae justo. "\
                                    "Fusce ...\nYou will be the 1st "\
                                    "commenter"
      end
    end

    context "BlagPost created with only comments and no comments are allowed" do
      it "will return a blank string" do
        blagpost = BlagPost.new(
          comments: [[]],
          publish_date: Date.today.years_ago(3),
        )
        expect(blagpost.to_s).to eq ""
      end
    end
  end
end
