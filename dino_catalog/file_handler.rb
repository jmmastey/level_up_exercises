require 'csv'

class FileHandler
  attr_accessor :file_name, :headers, :contents

  def initialize(file_name)
    #TODO, check for valid file/formatting
    @file_name = file_name

    #initialize contents
    @contents = []

    #chain to file load
    load_file()
  end

  #TODO CSV read function, headers option
  def load_file
    CSV.foreach(file_name) do |line|
      #check for headers (first line of file)
      unless headers.nil?
        @contents << line
      else
        @headers = line
      end
    end
  end

  def get_all_objects
    objects = []

    #loop through content
    contents.each do |content|
      objects << map_to_object(content)
    end

    objects
  end
end
