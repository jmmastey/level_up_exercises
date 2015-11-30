require 'json'
require './dinodex_app'
require './csv_utility'
require './filter_utility'
require './merge_utility'

class Dinodex < Thor
  desc "read_file FILE", "This task will read a file (You can search " \
    "based on given criteria. Also, provide an optional 'columns' option " \
    "'file_system' option or 'to_json' for JSON format)"
  method_option :criteria, :type => :hash, :required => false
  method_option :columns, :type => :array, :required => false
  method_option :to_json, :type => :boolean, :required => false
  def read_file(file)
    search_options = options[:criteria]
    columns = options[:columns]
    to_json = options[:to_json] || false
    app = DinodexApp.new(CsvUtility.new, FilterUtility.new, MergeUtility.new)
    data = app.read(file)
    data = app.filter(data, search_options) if search_options
    data = app.filter_columns(data, columns) if columns
    output = to_json ? JSON.generate(data) : app.write(data)
    puts output
  end

  desc "merge_files FILE1 FILE2", "This task will merge two data files. (You " \
    " can also provide 'to_json' option for JSON format)"
  method_option :mapping, :type => :hash, :required => true
  method_option :to_json, :type => :boolean, :required => false
  def merge_files(file1, file2)
    hash_object = options[:mapping]
    to_json = options[:to_json] || false
    app = DinodexApp.new(CsvUtility.new, FilterUtility.new, MergeUtility.new)
    data1 = app.read(file1)
    data2 = app.read(file2)
    data = app.merge_data(data1, data2, hash_object)
    output = to_json ? JSON.generate(data) : app.write(data)
    puts output
  end
end