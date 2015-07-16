def split_strip_sanitize(line)
  line.split(',').map { |d| d.strip.downcase }
end

def parse_dino_csv(filename)
  headers = []
  dino_data = []
  File.open(filename).each_with_index do |line, index|
    if index == 0
      headers = split_strip_sanitize(line)
      next
    end
    dino_data << Hash[headers.zip(split_strip_sanitize(line))]
  end
  dino_data
end
