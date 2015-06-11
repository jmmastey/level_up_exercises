require 'httparty'

module CallClassifyAPI
  MultiResponseCode = 4
  SingleResponseSummaryCode = 0
  SingleResponseVerboseCode = 2

  BaseURI = "http://classify.oclc.org/classify2/Classify"
  QueryFields = %w(stdndr oclc isbn issn upc owi author title)
  SummaryResponseFields = ["title", "author", "format", "owi"]
  VerboseResponseFields = ["title", "author", "format", "language", "oclc"]

  def self.generate_query(params, return_summary)
    query_string = {"summary" => true }
    query_string = {"summary" => false} if return_summary == false
    params.each do |search_key, search_val|
      query_string[search_key] = search_val.to_s if QueryFields.include?(search_key)
    end
    query_string
  end

  def self.query_api(params, return_summary)
    query_string = generate_query(params, return_summary)
    HTTParty.get(BaseURI, :query => query_string)
  end

  def self.parse_response(response)
    response_code = self.find_response_code(response)
    return self.find_error(response_code) if response_code >= 100
    tidy_response = clean_up_response(response, response_code)
    return self.build_list_of_books(tidy_response, response_code)
  end

  def self.find_response_code(response)
    response["classify"]["response"]["code"].to_i
  end

  def self.clean_up_response(response, response_code)
    puts 'what is response', response
    puts 'what is response code', response_code
    #puts 'response fields', response["classify"]["editions"]["edition"].keys if response_code == 2
    #Want an array of books so I can send all data to build_list_of_books
    return response["classify"]["works"]["work"] if response_code == MultiResponseCode #already an Array
    return [].push(response["classify"]["work"]) if response_code == SingleResponseSummaryCode
    if response_code == SingleResponseVerboseCode
      return [].push(response["classify"]["editions"]["edition"][0]) if response["classify"]["editions"]["edition"].class == Array
      return [].push(response["classify"]["editions"]["edition"]) if response["classify"]["editions"]["edition"].class == Hash
    end
  end

  def self.build_list_of_books(entries, response_code)
    response_fields = response_code == SingleResponseVerboseCode ? VerboseResponseFields : SummaryResponseFields
    all_results = []
    entries.each do |book|
      all_results.push(self.book_dict(book, response_fields))
    end
    all_results
  end  

  def self.book_dict(entry, response_fields)
    book_dict = {}
    response_fields.each do |field|
      if entry[field]
        book_dict[field] = entry[field]
      end
    end
    book_dict
  end

  def self.find_error(code)
    return "No input." if code == 100
    return "Invalid input." if code == 101
    return "No data found for this search" if code == 102
    return "Unexpected error" if code == 200
  end
end
