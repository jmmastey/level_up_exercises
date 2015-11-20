require './csv_utility'
require './library'

class Dinodex < Thor
  include Library

  desc "load_file FILE", "This task will load a single file with path provided"
  def load_file(file)
    data = CsvUtility.read_csv(file)
    Library.add_data(file, data)
  end

  desc "files", "This task will list files that were loaded"
  def files
    puts Library.get_all_files_loaded
  end

  desc "read_file FILE", "This task will read a file (You can search " \
    "based on given criteria. Also, provide an optional 'columns' option " \
    "and/or 'file_system' option)"
  method_option :criteria, :type => :hash, :required => false
  method_option :columns, :type => :array, :required => false
  method_option :file_system, :type => :boolean, :required => false
  def read_file(file)
    search_options = options[:criteria]
    columns = options[:columns]
    file_system = options[:file_system] || false
    data = Library.read_file(file, search_options, columns, file_system)
    puts CsvUtility.write_csv(data)
  end

  desc "remove_file FILE", "This task will delete a previously loaded file"
  def remove_file(file)
    Library.remove_file(file)
  end

  desc "list_columns", "This task will list all column names for each file"
  def list_columns
    files = Library.get_all_files_loaded
    files.each do |file|
      columns = Library.get_data_columns(file)
      puts "#{file} --> #{columns.to_s}"
    end
  end

  desc "merge_files FILE1 FILE2", "This task will merge two data files"
  method_option :mapping, :type => :hash, :required => true
  def merge_files(file1, file2)
    hash_object = options[:mapping]
    data = Library.merge_data(file1, file2, hash_object)
    puts CsvUtility.write_csv(data)
  end
end
