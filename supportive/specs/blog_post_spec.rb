require_relative '../blag_post.rb'

describe BlagPost do
  before(:each) do
    @author_name = "Foo Bar"
    @author_url = "http://www.google.com"
    @categories = [:theory_of_computation, :languages, :gossip]
    @comments = [[], [], []]
    @publish_date = "2013-02-10"
    @body = "FOOBAR"

    @blagpost = BlagPost.new(
      author: @author_name,
      author_url: @author_url,
      categories: @categories,
      comments: @comments,
      publish_date: @publish_date,
      body: @body,
    )
  end

  context "when creating a new BlagPost" do
    describe "#new" do
      it "has struct with @author_name" do
        expect(@blagpost.author.name).to eq @author_name
      end

      it "has struct with with @author_url" do
        expect(@blagpost.author.url).to eq @author_url
      end

      it "has categories containing allowed categories" do
        expect(@blagpost.categories).to eq [:theory_of_computation, :languages]
      end

      it "has @comments" do
        expect(@blagpost.comments).to eq @comments
      end

      it "has a parsed publish date" do
        expect(@blagpost.publish_date).to eq Date.parse(@publish_date)
      end

      it "has a @body" do
        expect(@blagpost.body).to eq @body
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
end
