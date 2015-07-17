class String
  def alpha?
    !match(/[^[:alnum:]]/)
  end

  def number?
    true if Float(self) rescue false
  end
end

class DinoParser
  TRANSLATE_MAP = {
    "genus" => "name",
    "carnivore" => "diet",
    "weight_in_lbs" => "weight",
  }
  TRANSLATE = -> h { TRANSLATE_MAP.include?(h) ? TRANSLATE_MAP[h] : h }

  def self.split_strip_downcase(line)
    line.split(',').map { |d| d.strip.downcase }
  end

  def self.grab_header
    self.split_strip_downcase(@f.first)
  end

  def self.grab_data
    dino_data = []
    @f.drop(1).each do |line|
      dino_data << Hash[@header.zip(self.split_strip_downcase(line))]
    end
    dino_data
  end

  def self.parse_csv(filename)
    @f = open(filename, 'r')
    @header = self.grab_header
    self.grab_data
  end
end

class DinoTranslator
  HEADER_MAP = {
    "genus" => "name",
    "carnivore" => "diet",
    "weight_in_lbs" => "weight",
  }

  def self.translate_key(hash, key)
    hash[HEADER_MAP[key]] = hash.delete key if HEADER_MAP.include?(key)
  end

  def self.translate_carnivore_key(h)
    carnivore_map = {
      "yes" => "carnivore",
      "no" => ""
    }
    h["carnivore"] = carnivore_map[h["carnivore"]] if h.include? "carnivore"
  end

  def self.translate_header(data)
    data.each { |h| h.keys.each { |k| self.translate_key(h, k) } }
  end

  def self.translate_data(data)
    data.each { |h| self.translate_carnivore_key(h) }
  end

  def self.translate(data)
    self.translate_data(data)
    self.translate_header(data)
    data
  end
end

class DinoValidator
  DISPATCHER = {
    "name" => self.valid_name?,
    "period" => self.valid_period?,
    "continent" => self.valid_continent?,
    "diet" => self.valid_diet?,
    "weight" => self.valid_weight?,
    "walking" => self.valid_walking?,
    "desc" => self.valid_desc?,
  }

  def self.valid_input?(data)
    data.each { |row| self.valid_row?(row) }
  end

  def self.valid_row?(row)

  end

  def self.valid_name?(name)
    name.alpha?
  end

  def self.valid_period?(period)
    period.alpha?
  end

  def self.valid_continent?(continent)
    continent.alpha?
  end

  def self.valid_diet?(diet)
    diet.alpha?
  end

  def self.valid_weight?(weight)
    weight.number?
  end

  def self.valid_walking?(walking)
    walking.alpha?
  end

  def self.valid_desc?(desc)
    true
  end
end