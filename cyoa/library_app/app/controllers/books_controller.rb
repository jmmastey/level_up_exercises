#require_relative '../../lib/api_interaction/call_classify_api.rb'
require "api_interaction/call_classify_api"
require "api_interaction/call_googlebooks_api"

class BooksController < ApplicationController
 # before_filter :authenticate_user!

  def search
  end

  def results
    response = CallClassifyAPI::query_api(params, true)
    @parsed_response = CallClassifyAPI::parse_response(response)
  end

  def select_item
    authenticate_user! if !user_signed_in?
    puts 'who is the current user', current_user.email
    #Query the api again with the owi number for the user's selected book to get detailed listing (and oclc num)
    query = { "owi" => params["owi"] }
    response = CallClassifyAPI::query_api(query, false)
    @book_data = CallClassifyAPI::parse_response(response)[0]
    google_query = {"OCLC" => @book_data["oclc"] }
    puts 'google query is', google_query
    @book_thumbnail = CallGoogleBooksAPI::query_api(google_query)
    @book_thumbnail = CallGoogleBooksAPI::get_thumbnail_url(@book_thumbnail, google_query)
    @book_data["thumbnail_url"] = @book_thumbnail
    puts 'book data now', @book_data
    #need to check if the book is already in book table and in user's collection
    if Book.where(oclc: @book_data["oclc"]).length == 1
      book = Book.where(oclc: @book_data["oclc"])[0]
    else
      book = Book.new(@book_data)
      book.save
    end
    #Need the id of the book
    book_match = current_user.books.all.select{ |existing_book| existing_book.oclc == book.oclc }
    if book_match.length == 0
      current_user.books << book
    else
      @message = "The book is already in your library"
    end
  end

  def user_collection
    authenticate_user! if !user_signed_in?
    puts 'user signed in?', user_signed_in?
    #Allows user to view the library
    @current_user_library = current_user.books.all
    @current_user_name = current_user.email
  end

  def detailed_book_info
    authenticate_user! if !user_signed_in?
    #Fetch info about book
    oclc_num = params["oclc"]
    @book_of_interest = Book.where(oclc: oclc_num)[0]
    #Does user have comments about the book to display?
    @book_comments = current_user.comments.all.select { |comment| comment.book_id == @book_of_interest.id }
  end

  def destroy
    authenticate_user! if !user_signed_in?
    book_id = params[:id]
    #Remove book from user's library
    @transaction = current_user.books.delete(book_id) if current_user.books.find_by(id:book_id)
  end
end
