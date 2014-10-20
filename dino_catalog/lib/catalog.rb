require 'CSV'

class Catalog

  # Initialize the new catalog

  def initialize(path=nil)
    # locate the file
    @filepath = File.join(APP_ROOT, path)
    puts @filepath

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
    #File.open(path) do |f|
      #while record - f.gets
        #csv_line = record.chomp.split(',')
        #puts csv_line
      #end
    #end
    CSV.read(file_path).each do |line|
      puts line.inspect
    end
    # add dinosaurs to the catalog

  end

  # launch the program

  # get the user's input

  # do what the user requests

end
