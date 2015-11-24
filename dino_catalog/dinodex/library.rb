require './csv_utility'
require './data/hbase_service.rb'

module Library
  include HbaseService

  def self.add_data(name, data_array)
    HbaseService.put(name, data_array)
  end

  def self.get_data(name, file_system = false)
    file_system ? CsvUtility.read_csv(name) : HbaseService.get(name)
  end

  def self.remove_file(name)
    HbaseService.delete(name)
  end

  def self.get_data_columns(name)
    get_data(name).first.keys
  end

  def self.get_all_files_loaded
    HbaseService.scan_rowkeys
  end

  def self.merge_data(name1, name2, name1_to_name2_mapping)
    result_data = []

    common_columns = get_data_columns(name1) & get_data_columns(name2)
    current_data = get_data(name1) + get_data(name2)

    current_data.each do |data|
      data_object = data.select { |key, _| common_columns.include?(key) }
      data_object.merge!(create_hash_from_mapping(data, name1_to_name2_mapping))
      result_data << data_object if data_object.length > 0
    end

    result_data
  end

  def self.create_hash_from_mapping(hash, column_mapping)
    result_hash = {}

    column_mapping.each do |name1_col, name2_col|
      if hash.key?(name1_col)
        result_hash[name1_col] = hash[name1_col]
      elsif hash.key?(name2_col)
        result_hash[name1_col] = hash[name2_col]
      end
    end

    result_hash
  end

  def self.read_file(file, search_options, columns, file_system)
    data = get_data(file, file_system)
    data = filter_data(data, search_options) if search_options
    data = filter_columns(data, columns) if columns
    data
  end

  def self.filter_data(data, search_options)
    search_keys, search_criteria = build_search_params(search_options)
    filter_data_objects(data, search_keys, search_criteria)
  end

  def self.filter_data_objects(data, search_keys, search_criteria)
    result_data = []

    data.each do |data_object|
      data_object.each do |obj_key, obj_value|
        if add_to_results?(search_keys, obj_key, obj_value, search_criteria)
          result_data << data_object
          break
        end
      end
    end

    result_data
  end

  def self.add_to_results?(search_keys, obj_key, obj_value, search_criteria)
    search_keys.include?(obj_key) &&
      !obj_value.nil? &&
      criteria_match?(obj_key, obj_value, search_criteria)
  end

  def self.build_search_params(search_options)
    search_keys = []
    search_criteria = []

    search_options.each do |search_key, search_value|
      search_keys << search_key
      search_criteria << parse_search_values(search_value).unshift(search_key)
    end

    return search_keys, search_criteria
  end

  def self.filter_columns(data, columns)
    return unless columns
    data.each do |data_object|
      data_object.delete_if { |key, _| !columns.include?(key) }
    end
  end

  def self.parse_search_values(string)
    return ["==", ""] if string.nil? || string.length == 0
    return ["=~", string.split(/=~/).last] if string.include?("=~")
    parse_equality_values(string)
  end

  def self.parse_equality_values(string)
    glt_index = string.index(/[<>]/)
    operator = glt_index.nil? ? "==" : string[glt_index]
    operator += "=" if string.include?("=") && !glt_index.nil?
    [operator] << string.split(/[<>=]/).last
  end

  def self.criteria_match?(object_key, value, search_criteria)
    return_value = false
    search_criteria.each do |entry|
      search_key = entry[0]
      operator = entry[1]
      if search_key == object_key
        value = convert_from_string(value, false)
        criteria = convert_from_string(entry[2], operator.include?("~"))
        return_value = value.send(operator, criteria)
        break
      end
    end
    return_value
  end

  private

  def self.convert_from_string(string, regex_operator)
    value = regex_operator ? /#{string}/ : string
    value = string.to_i if number?(string)
    value
  end

  def self.number?(string)
    true if Float(string) rescue false
  end
end
