#require_relative '../../lib/api_interaction/call_classify_api.rb'
require "api_interaction/call_classify_api"

class BooksController < ApplicationController
  before_filter :authenticate_user!

  def search
  end

  def results
    response = CallClassifyAPI::query_api(params, true)
    @parsed_response = CallClassifyAPI::parse_response(response)
  end

  def select_item
    redirect_to new_user_session_path if !user_signed_in?
    puts 'who is the current user', current_user.email
    #Query the api again with the owi number for the user's selected book to get detailed listing (and oclc num)
    query = { "owi" => params["owi"] }
    response = CallClassifyAPI::query_api(query, false)
    @book_data = CallClassifyAPI::parse_response(response)[0]
    #need to check if the book is already in book table and in user's collection
    book = Book.new(@book_data)
    book.save if !Book.exists?(oclc: book[:oclc])
    #Need the id of the book
    if current_user.books.all.select { |existing_book| existing_book[:oclc] == book[:oclc] }.length == 0
      current_user.books << book
    else
      "The book is already in your library"
    end
  end

  def user_collection
    #Allows user to view the library
    @current_user_library = current_user.books.all
    @current_user_name = current_user.email
  end

  def detailed_book_info
    #Fetch info about book
    oclc_num = params["oclc"]
    @book_of_interest = Book.where(oclc: oclc_num)[0]
    #Does user have comments about the book to display?
    puts 'any comments?', current_user.comments.all.length
    @book_comments = current_user.comments.all.select do |comment|
      puts 'comment book, book of interest'
      puts comment.book_id,  @book_of_interest.id
    end
    @book_comments = current_user.comments.all.select { |comment| comment.book_id == @book_of_interest.id }
    puts 'how many comments?', @book_comments.length
  end

end
