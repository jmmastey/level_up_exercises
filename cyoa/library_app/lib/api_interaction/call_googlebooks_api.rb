require 'httparty'
 
module CallGoogleBooksAPI
  BaseURI = "http://www.books.google.com/books"
  Bibkeys = ["OCLC"]
  def self.generate_query(params)
    query_string = {"jscmd" => "viewapi"}
    Bibkeys.each do |key|
      if params[key]
        bibkey = "#{key}:#{params[key]}"
        query_string["bibkeys"] = bibkey
      end
    end
    query_string
  end
    
  def self.query_api(params)
    query_string = self.generate_query(params)
    HTTParty.get(BaseURI, :query => query_string)
  end
    
  def self.get_thumbnail_url(response, query_params)
    #Fish out the thumbnail url
    #Build string with query params
    bibkey = "#{query_params.keys[0]}:#{query_params.values[0]}"
    response.slice!('var _GBSBookInfo =')
    response.slice!(";")   
    response = JSON.parse(response)
    response[bibkey]["thumbnail_url"] if response[bibkey]
  end

  def self.query_and_extract_thumbnail_url(user_query)
    query_result = self.query_api(user_query)
    self.get_thumbnail_url(query_result, user_query)
  end

end 
