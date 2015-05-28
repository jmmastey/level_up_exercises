require 'httparty'

module CallClassifyAPI
  MultiResponseCode = "4"
  SingleResponseSummaryCode = "0"
  SingleResponseVerboseCode = "2"

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

  def self.delegate_output(response)
    response_code = response["classify"]["response"]["code"]
    if response_code == MultiResponseCode #passes a list
      response_display = self.display_response(response["classify"]["works"]["work"])
    end
    if response_code == SingleResponseSummaryCode #passes a hash 
      response_display = self.display_single_entry(response["classify"]["work"],SummaryResponseFields)
    end
    if response_code == SingleResponseVerboseCode #passes a hash 
      response_display = self.display_single_entry(response["classify"]["editions"]["edition"][0], VerboseResponseFields)
    end
    response_display
  end

  def self.display_single_entry(entry, display_fields)
    #Build a string containing the info that should be displayed about the title
    display_string = display_fields.map do |field|
      if entry[field]
        "#{field}: #{entry[field]} \n"
      end
    end
    display_string.select { |book_string| book_string }
  end

  def self.display_response(entries)
    all_results = entries.map do |entry|
      self.display_single_entry(entry, SummaryResponseFields)
    end
    all_results
  end
end
