class Catalog

  # load in the csv file

  @@filepath = nil

  def initialize(path=nil)
    # locate the file
    @@filepath = File.join(APP_ROOT)
    puts @@filepath
    # if file exists, parse it
    if @@filepath && File.exists?(@@filepath)
      puts "I found a file!"
    else
      raise IOError, "No file was found"
    end
  end

  # launch the program

  # get the user's input

  # do what the user requests

end
