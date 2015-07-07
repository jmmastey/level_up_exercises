require 'csv'

class Importer
  attr_reader :entity, :options
  attr_accessor :data_set

  def initialize(options, entity)
    self.data_set = {}
    @entity = entity
    @options = options
    load_data_files(options[:path])
  end

  private

  def load_data_files(path)
    Dir.glob(path).each do |file|
      if file_is_csv?(file)
        # The next line is necessary to make sure that the option for
        # the path is not sent to the CSV reading functionality.
        options.delete(:path)
        create_data_set(CSV.read(file, options))
      end
    end
  end

  def create_data_set(file_contents)
    file_contents.by_row.each do |row|
      row.headers.each_with_object({}) do |header, data|
        data[header] = row[header]
        data_set[data[:name]] = entity.new(data)
      end
    end
  end

  def file_is_csv?(file)
    File.extname(file) == '.csv'
  end
end
