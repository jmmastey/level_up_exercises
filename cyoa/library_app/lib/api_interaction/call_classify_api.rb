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
    if response_code == MultiResponseCode
      return self.build_list_of_books(response["classify"]["works"]["work"])
    end
    if response_code == SingleResponseSummaryCode
      return self.book_dict(response["classify"]["work"], SummaryResponseFields)
    end
    if response_code == SingleResponseVerboseCode
      return self.book_dict(response["classify"]["editions"]["edition"][0], VerboseResponseFields)
    end
  end

  def self.build_list_of_books(entries)
    all_results = []
    entries.each do |book|
      all_results.push(self.book_dict(book, SummaryResponseFields))
    end
    all_results
  end  

  def self.find_response_code(response)
    response["classify"]["response"]["code"].to_i
  end

  def self.find_error(code)
    return "No input." if code == 100
    return "Invalid input." if code == 101
    return "No data found for this search" if code == 102
    return "Unexpected error" if code == 200
  end

  def self.book_dict(entry, display_fields)
    book_dict = {}
    display_fields.each do |field|
      if entry[field]
        book_dict[field] = entry[field]
      end
    end
    book_dict
  end
    
end
