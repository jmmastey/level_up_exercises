require 'csv'

class Importer
  attr_reader :entity
  attr_accessor :data_set

  def initialize(path, entity)
    self.data_set = {}
    @entity = entity
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
      data_set[data[:name]] = entity.new(data)
    end
  end

  def file_is_csv?(file)
    File.extname(file) == '.csv'
  end
end
