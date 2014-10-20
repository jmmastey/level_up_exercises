require 'CSV'
require_relative 'dinosaur'

class Catalog

  # Initialize the new catalog

  def initialize(path=nil)
    # locate the file
    @filepath = File.join(APP_ROOT, path)

    # if file exists, parse it
    if @filepath && File.exists?(@filepath)
      puts "I found a file!"
      build_catalog(@filepath)
    else
      raise IOError, "No file was found"
    end
  end

  # load in the csv file

  def build_catalog(file_path)
    # read the file
    CSV.read(file_path, headers: true, header_converters: :symbol).each do |data|
      create_dinosaur_entry(data[:name])
    end
  end

  def create_dinosaur_entry(attributes)
    Dinosaur.new(attributes)
  end


  # launch the program

  # get the user's input

  # do what the user requests

end
