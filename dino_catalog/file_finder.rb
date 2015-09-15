class FileFinder
  attr_accessor :files, :file_type
  attr_reader :directory_path

  ERROR_NO_DIRECTORY = "[Error] Directory specified does not exist."

  def initialize(directory_path = ".", file_type = "*")
    @files            = []
    @file_type        = file_type
    @directory_path   = directory_path

    Dir.chdir(@directory_path)
    @directory_path = File.join(Dir.pwd, "/")
    search
  end

  def directory_path=(path)
    return puts ERROR_NO_DIRECTORY unless Dir.exist?(path)
    Dir.chdir(path)
    @directory_path = File.join(Dir.pwd, "/")
    true
  end

  def search
    @files = []
    Dir.glob(file_type) { |file_name| @files.push(@directory_path + file_name) }
    files
  end
end
