#require_relative '../../lib/api_interaction/call_classify_api.rb'
require "api_interaction/call_classify_api"
require "api_interaction/call_googlebooks_api"

class BooksController < ApplicationController

  def search
  end

  def results
    response = CallClassifyAPI.query_api(params, true)
    @parsed_response = CallClassifyAPI.parse_response(response)
  end

  def select_item
    authenticate_user! if !user_signed_in?
    # Query the api again with the owi number for the user's selected book to 
    # get detailed listing (and oclc num needed by google books api)
    classify_query = { "owi" => params["owi"] }
    @book_data = CallClassifyAPI.query_and_extract_book(classify_query, false)
    google_query = {"OCLC" => @book_data["oclc"] }
    @book_data["thumbnail_url"] = CallGoogleBooksAPI.query_and_extract_thumbnail_url(google_query)
    if Book.in_database?(@book_data["oclc"])
      book = Book.where(oclc: @book_data["oclc"]).first
    else
      book = Book.create(@book_data)
    end
    return @message = "The book is already in your library" if Book.book_in_library?(current_user, book)
    current_user.books << book
  end

  def user_collection
    authenticate_user! if !user_signed_in?
    @current_user_library = current_user.books.all
    @current_user_name = current_user.email
  end

  def detailed_book_info
    authenticate_user! if !user_signed_in?
    #Fetch info about book
    oclc_num = params["oclc"]
    @book_of_interest = Book.where(oclc: oclc_num).first
    @book_comments = current_user.comments.where(book_id: @book_of_interest.id)
    book_recommendation = current_user.recommendations.where(recommended:true, book_id:@book_of_interest.id)
    @recommended = book_recommendation.length == 1
  end

  def destroy
    authenticate_user! if !user_signed_in?
    book_id = params[:id]
    #Remove book from user's library
    @transaction = current_user.books.delete(book_id) if current_user.books.find_by(id:book_id)
  end

  def add_rec_book
    authenticate_user! if !user_signed_in?
    oclc_num = params[:oclc]
    @book = Book.find_by_oclc(oclc_num)
    current_user.books << @book if !Book.book_in_library?(current_user, @book)
  end
end
