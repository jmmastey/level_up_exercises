class CustomFilter
  HASH_SPLIT_REGEXP = /\s*(?:,|:)\s/
  private_constant :HASH_SPLIT_REGEXP

  def initialize(description)
    @description = description
  end

  def call(items)
    print_instructions(items)
    hash = read_filter
    puts

    items.reject! { |d| reject_item?(d, hash) }
  rescue StandardError
    puts "Invalid filter\n"
  end

  private

  def print_instructions(items)
    puts @description
    puts 'Fields:'
    list_of_filterable_fields(items).each { |f| puts " - #{f}" }
    print '> '
  end

  def list_of_filterable_fields(items)
    items.first.instance_variables.map { |v| v.to_s.delete('@') }
  end

  def read_filter
    hash_string = $stdin.readline.chomp
    convert_input_to_hash(hash_string)
  end

  def convert_input_to_hash(hash_string)
    Hash[*hash_string.delete('"').split(HASH_SPLIT_REGEXP)]
  end

  def reject_item?(item, field_hash)
    field_hash.find do |field, filter_value|
      field_value = item.instance_variable_get("@#{field}")
      reject_item_for_field?(field_value, filter_value)
    end
  end

  def reject_item_for_field?(field_value, filter_value)
    if field_value.is_a?(Array)
      !field_value.include?(filter_value)
    else
      field_value.nil? || field_value.to_s != filter_value.to_s
    end
  end
end
