#require_relative '../../lib/api_interaction/call_classify_api.rb'
require "api_interaction/call_classify_api"
require "api_interaction/call_googlebooks_api"

class BooksController < ApplicationController
  before_filter :authenticate_user!, except: [:search, :results]

  def search
  end

  def results
    @book_list = CallClassifyAPI.query_and_extract_booklist(params, true)
  end

  def select_item
    # Query api again with owi number for selected book to get detailed listing (including oclc needed by GoogleBooksAPI)
    @book_data = CallClassifyAPI.query_and_extract_book({ "owi" => params["owi"] }, false)
    @book_data["thumbnail_url"] = CallGoogleBooksAPI.query_and_extract_thumbnail_url({"OCLC" => @book_data["oclc"] })
    book = Book.create_with(@book_data).find_or_create_by(oclc: @book_data["oclc"])
    return @message = "The book is already in your library" if Book.book_in_library?(current_user, book)
    current_user.books << book
  end

  def user_collection
    @current_user_library = current_user.books.all
    @current_user_name = current_user.email
  end

  def detailed_book_info
    #Fetch info about book
    oclc_num = params["oclc"]
    @book_of_interest = Book.where(oclc: oclc_num).first
    @book_comments = current_user.comments.where(book_id: @book_of_interest.id)
    book_recommendation = current_user.recommendations.where(recommended:true, book_id:@book_of_interest.id)
    @recommended = book_recommendation.length == 1
  end

  def destroy
    #Remove book from user's library
    book_id = params[:id]
    @transaction = current_user.books.delete(book_id) if current_user.books.find_by(id:book_id)
  end

  def add_rec_book
    oclc_num = params[:oclc]
    @book = Book.find_by_oclc(oclc_num)
    current_user.books << @book if !Book.book_in_library?(current_user, @book)
  end
end
