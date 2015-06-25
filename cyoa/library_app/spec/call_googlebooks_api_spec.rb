require 'api_interaction/call_classify_api.rb'
require 'api_interaction/call_googlebooks_api.rb'
require 'vcr'
require 'vcr_setup.rb'

USER_QUERY = { "title" => "Isaac's Storm" }
BOOK_TITLE = "Isaac's storm : a man, a time, and the deadliest hurricane in history"
OCLC_NUM = "41002882"
URL_MATCH = "https://books.google.com/books/content?id=sOsTAAAAYAAJ&printsec=frontcover&img=1&zoom=5"

describe do
  it "gets the url of the thumbnail for the book" do
    VCR.use_cassette("google_api_call") do
      book_list = CallClassifyAPI.query_and_extract_booklist(USER_QUERY, true)
      new_query = { "owi" => book_list[0]["owi"] }
      book = CallClassifyAPI.query_and_extract_book(new_query, false)
      thumbnail_url = CallGoogleBooksAPI.query_and_extract_thumbnail_url("OCLC" => book["oclc"])
      expect(thumbnail_url).to eql(URL_MATCH)
    end
  end
end
