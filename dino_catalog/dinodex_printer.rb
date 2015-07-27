require_relative 'dinosaur'

module DinodexPrinter
  COLUMN_MAX_LENGTHS = {
    'name' => 0,
    'period' => 0,
    'continent' => 0,
    'diet' => 0,
    'weight' => 0,
    'walking' => 0,
    'description' => 0,
  }

  def self.build_table_header(columns)
    header = "|"
    columns.each do |key, max_len|
      spaces = " " * (max_len - key.length) + " |"
      header += " " + key + spaces
    end
    header
  end

  def self.build_cell(dino, key, max_len)
    data = dino.has?(key) ? dino.data[key] : ""
    data_len = dino.has?(key) ? dino.data[key].length : 0
    " #{data}#{'.' * (max_len - data_len)} |"
  end

  def self.build_table_row(dino, columns)
    row = "|"
    columns.each { |key, max_len| row += build_cell(dino, key, max_len) }
    row += "\n"
  end

  def self.build_table_body(subset, columns)
    body = ""
    subset.each { |dino| body += build_table_row(dino, columns) }
    body
  end

  def self.calc_max_column_lengths(subset)
    columns_max_len = COLUMN_MAX_LENGTHS
    columns_max_len.keys.each do |key|
      dino = subset.max_by { |d| d.has?(key) ? d.data[key].length : 0 }
      next unless dino.has?(key)
      columns_max_len[key] = dino.data[key].length
    end
    columns_max_len
  end

  def self.calc_column_lengths(subset)
    columns_max_len = calc_max_column_lengths(subset)
    remove_blank_columns(columns_max_len)
  end

  def self.remove_blank_columns(columns_max_len)
    columns_max_len.keys.each do |key|
      columns_max_len.delete key if columns_max_len[key] == 0
      next if columns_max_len[key] == 0
      v = columns_max_len[key]
      columns_max_len[key] = v > key.length ? v : key.length
    end
    columns_max_len
  end

  def self.print(subset)
    columns = calc_column_lengths(subset)
    header = build_table_header(columns)
    body = build_table_body(subset, columns)

    puts header
    puts '-' * header.length
    puts body
  end
end
