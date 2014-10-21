class App

  def initialize(name)
    @filepath = File.join(APP_ROOT, name)
    @app_name = name
    check_file(@filepath)
    create_catalog(@filepath, @name)
  end

  def check_file(filepath)
    if filepath && File.exists?(filepath)
      puts "I found a file!"
    else
      raise IOError, "No file was found"
    end
  end

  def create_catalog(filepath, name)
    Catalog.new(filepath, name)
  end


end
