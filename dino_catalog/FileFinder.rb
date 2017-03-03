class FileFinder

  attr_accessor :files, :file_type
  attr_reader :directory_path
  
  ERROR_NO_DIRECTORY  = "[Error] Directory specified does not exist."

  def initialize(directory_path = ".", file_type = "*")
    @files            = []
    @file_type        = file_type
    @directory_path   = directory_path

    Dir.chdir(@directory_path)
    @directory_path = set_proper_path(Dir.pwd)
    search
  end

  def directory_path=(path)
    return puts ERROR_NO_DIRECTORY if Dir.exists?(path) == false
    Dir.chdir(path)
    @directory_path = set_proper_path(Dir.pwd)
    return true
  end

  def exists?(path)
    Dir.exists?(path)
  end

  def search
    @files = []
    Dir.glob(file_type) { |file_name| @files.push(@directory_path + file_name) }
    files.length
  end

  def set_proper_path(directory_path)
    return directory_path << '/' unless directory_path.end_with?('/')
  end
end