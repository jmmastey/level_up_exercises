require 'csv'

class FileHandler
  #name of file to import
  attr_accessor :file_name
  #array of headers
  attr_accessor :headers
  #array of content
  attr_accessor :contents

  def initialize(file_name)
    #TODO, check for valid file/formatting
    @file_name = file_name

    #initialize contents
    @contents = []

    #chain to file load
    load_file()
  end

  def load_file()
    CSV.foreach(file_name) do |line|
      #check for headers (first line of file)
      unless headers.nil?
        @contents << line
      else
        @headers = line
      end
    end
  end
end