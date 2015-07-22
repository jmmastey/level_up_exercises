require('json')
class JSONParser
  def init
  end

  def parse(filepath)
    raise_file_error unless File.exist?(filepath)
    file = File.read(filepath)
    if file.empty?
      {}
    else
      JSON.parse(file)
    end
  end

  def raise_file_error
    raise(ArgumentError, 'File does not exist')
  end
end
