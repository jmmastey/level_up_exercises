module DinoParser
  def self.split_strip(line)
    line.split(',').map(&:strip)
  end

  def self.parse_header
    split_strip(@file.first).map(&:downcase)
  end

  def self.parse_rows
    @file.each_with_object([]) do |row, dino_data|
      dino_data << Hash[@header.zip(split_strip(row))]
    end
  end

  def self.parse_csv(filename)
    @file = open(filename, 'r')
    @header = parse_header
    parse_rows
  end
end
