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
    File.open(file_name, 'r') do |f|
      f.each_line do |line|
        #check for headers (first line of file)
        unless headers.nil?
          @contents << line.split(',')
        else
          @headers = line.split(',')
        end
      end
    end
  end

  def map_to_dinosaur()
    #child class invokes this method
  end
end