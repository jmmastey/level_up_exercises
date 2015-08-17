require_relative 'dinosaur'

module DinodexPrinter
  def self.build_table_header(columns)
    header = "|"
    columns.each do |key, max_len|
      spaces = " " * (max_len - key.length)
      header << " #{key}#{spaces} |"
    end
    header
  end

  def self.build_table_cell(dino, key, max_len)
    data = dino.has?(key) ? dino.data[key] : ""
    data_len = dino.has?(key) ? dino.data[key].length : 0
    " #{data}#{'.' * (max_len - data_len)} |"
  end

  def self.build_table_row(dino, columns)
    row = "|"
    columns.each { |key, max_len| row << build_table_cell(dino, key, max_len) }
    row << "\n"
  end

  def self.build_table_body(dinos, columns)
    dinos.each_with_object("") do |dino, body|
      body << build_table_row(dino, columns)
    end
  end

  def self.find_columns(dinos)
    columns = []
    dinos.each { |dino| columns |= dino.data.keys }
    Hash[columns.product([0])]
  end

  def self.calc_column_max_lengths(dinos)
    columns_max_len = find_columns(dinos)
    columns_max_len.keys.each do |key|
      dino = dinos.max_by { |d| d.has?(key) ? d.data[key].length : 0 }
      next unless dino.has?(key)
      columns_max_len[key] = dino.data[key].length
    end
    columns_max_len
  end

  def self.calc_column_lengths(dinos)
    columns_max_len = calc_column_max_lengths(dinos)
    remove_blank_column_lengths(columns_max_len)
  end

  def self.remove_blank_column_lengths(columns_max_len)
    columns_max_len.each do |dino_attr, col_len|
      columns_max_len.delete(dino_attr) if columns_max_len[dino_attr] == 0
      new_col_len = (col_len > dino_attr.length) ? col_len : dino_attr.length
      columns_max_len[dino_attr] = new_col_len
    end
    columns_max_len
  end

  def self.print(dinos)
    columns = calc_column_lengths(dinos)
    header = build_table_header(columns)
    body = build_table_body(dinos, columns)

    puts header
    puts '-' * header.length
    puts body
  end
end
