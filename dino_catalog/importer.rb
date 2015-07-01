require 'csv'

class Importer
  def initialize(path)
    get_data_files(path)
  end

  private

  def get_data_files(path)
    Dir.glob(path).each do |file|
      load_file(file) if file_is_csv?(file)
    end
  end

  def load_file(file)
    CSV.read(file)
  end

  def file_is_csv?(file)
    File.extname(file) == '.csv'
  end
end
