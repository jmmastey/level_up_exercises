require_relative '../../lib/api_interaction/call_classify_api.rb'

class BooksController < ApplicationController

  def get_search_query
  end

  def perform_search
    response = CallClassifyAPI::query_api(params, true)
    @parsed_response = CallClassifyAPI::parse_response(response)
  end

  def select_item
    #Query the api again with the owi number for the user's selected book to get detailed listing (and oclc num)
    query = { "owi" => params["owi"] }
    response = CallClassifyAPI::query_api(query, false)
    @book = CallClassifyAPI::parse_response(response)
  end

end
