class MergeUtility
  def merge_data(data1, data2, name_mapping)
    common_columns = data1.first.keys & data2.first.keys
    current_data = data1 + data2
    generate_data(current_data, common_columns, name_mapping)
  end

  private

  def generate_data(current_data, common_columns, name_mapping)
    current_data.inject([]) do |result_data, data|
      data_object = data.select { |key, _| common_columns.include?(key) }
      data_object.merge!(create_hash_from_mapping(data, name_mapping))
      result_data << data_object if data_object.length > 0
      result_data
    end
  end

  def create_hash_from_mapping(hash, column_mapping)
    column_mapping.inject({}) do |result_hash, (name1_col, name2_col)|
      result_hash[name1_col] = hash[name1_col] || hash[name2_col]
      result_hash
    end
  end
end
