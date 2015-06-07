require 'httparty'
 
module CallGoogleBooksAPI
  BaseURI = "http://www.books.google.com/books"
  Bibkeys = ["OCLC"]
  def self.generate_query(params)
    query_string = {"jscmd" => "viewapi"}
    Bibkeys.each do |key|
      if params[key]
        bibkey = "#{key}:#{params[key]}"
        puts 'the bibkey is', bibkey
        query_string["bibkeys"] = bibkey
      end
    end
    return query_string
  end
    
  def self.query_api(params)
    query_string = self.generate_query(params)
    puts 'query_tring', query_string
    HTTParty.get(BaseURI, :query => query_string)
  end
    
  def self.get_thumbnail_url(response, query_params)
    #Fish out the thumbnail url
    #Build string with query params
    bibkey = "#{query_params.keys[0]}:#{query_params.values[0]}"
    response.slice!('var _GBSBookInfo =')
    response.slice!(";")   
    response = JSON.parse(response)
    response[bibkey]["thumbnail_url"]
  end

end 
