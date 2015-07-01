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
    create_data_set(CSV.read(file, headers: true))
  end

  def create_data_set(file_contents)
    file_contents.by_row.each do |row|
      data = {}
      row.headers.each do |header|
        data[header] = row[header]
      end
    end
  end

  def file_is_csv?(file)
    File.extname(file) == '.csv'
  end
end
