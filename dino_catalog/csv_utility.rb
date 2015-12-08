require "csv"

class CsvUtility
  def write(data_objects)
    return "" if data_objects.nil? || data_objects.length == 0
    CSV.generate do |csv_data|
      csv_data << data_objects.first.keys
      data_objects.each do |data_object|
        csv_data << data_object.values
      end
    end
  end

  def read(path)
    raise "You need to specify a path and file" unless valid_path?(path)
    csv_options = { encoding: "UTF-8", skip_blanks: true, headers: true }
    process_csv_rows(path, csv_options)
  end

  private

  def valid_path?(path)
    return false if path.nil?
    return false unless path.to_s =~ /\w.csv/
    File.file?(path)
  end

  def process_csv_rows(path, csv_options)
    data_objects = []

    CSV.foreach(path, csv_options) do |row|
      data_objects << process_row(row)
    end

    data_objects
  end

  def process_row(row)
    data = {}

    row.headers.each do |header|
      data[header.gsub(/\s/, "_").downcase] = row[header]
    end

    data
  end
end
