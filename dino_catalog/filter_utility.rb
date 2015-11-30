class FilterUtility
  def filter_data(data, search_options)
    search_criteria = build_search_params(search_options)
    data.delete_if do |data_object|
      !data_matches?(data_object, search_criteria)
    end
  end

  def data_matches?(data_object, search_criteria)
    data_object.each do |obj_key, obj_value|
      return true if matches_search?(obj_key, obj_value, search_criteria)
    end
    false
  end

  def matches_search?(obj_key, obj_value, search_criteria)
    criteria_includes?(obj_key, search_criteria) &&
      !obj_value.nil? &&
      criteria_match?(obj_key, obj_value, search_criteria)
  end

  def build_search_params(search_options)
    search_criteria = []
    search_options.each do |search_key, search_value|
      search_criteria << parse_search_values(search_value).unshift(search_key)
    end
    search_criteria
  end

  def filter_columns(data, columns)
    return unless columns
    data.each do |data_object|
      data_object.delete_if { |key, _| !columns.include?(key) }
    end
  end

  def parse_search_values(string)
    return ["==", ""] if string.nil? || string.length == 0
    return ["=~", string.split(/=~/).last] if string.include?("=~")
    parse_equality_values(string)
  end

  def parse_equality_values(string)
    glt_index = string.index(/[<>]/)
    operator = glt_index.nil? ? "==" : string[glt_index]
    operator += "=" if string.include?("=") && !glt_index.nil?
    [operator] << string.split(/[<>=]/).last
  end

  def criteria_match?(object_key, value, search_criteria)
    match = false
    search_criteria.each do |entry|
      match = values_equal?(value, entry[2], entry[1]) if entry[0] == object_key
      break if entry[0] == object_key
    end
    match
  end

  private

  def values_equal?(value, criteria, operator)
    value = convert_from_string(value, false)
    criteria = convert_from_string(criteria, operator.include?("~"))
    value.send(operator, criteria)
  end

  def criteria_includes?(obj_key, search_criteria)
    search_criteria.each do |entry|
      return true if obj_key == entry[0]
    end
    false
  end

  def convert_from_string(string, regex_operator)
    value = regex_operator ? /#{string}/ : string
    value = string.to_i if number?(string)
    value
  end

  def number?(string)
    string =~ /\A[-+]?\d+\z/
  end
end
