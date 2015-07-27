module DinoParser
  def self.split_strip_downcase(line)
    line.split(',').map { |d| d.strip.downcase }
  end

  def self.grab_header
    split_strip_downcase(@f.first)
  end

  def self.grab_data
    dino_data = []
    @f.each do |line|
      dino_data << Hash[@header.zip(split_strip_downcase(line))]
    end
    dino_data
  end

  def self.parse_csv(filename)
    @f = open(filename, 'r')
    @header = grab_header
    grab_data
  end
end
