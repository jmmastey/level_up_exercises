InvalidDataError = Class.new(RuntimeError)

class String
  def alpha?
    match(/^[a-z ]*$/) != nil
  end

  def number?
    true if Float(self) rescue false
  end
end

class DinoParser
  def self.split_strip_downcase(line)
    line.split(',').map { |d| d.strip.downcase }
  end

  def self.grab_header
    self.split_strip_downcase(@f.first)
  end

  def self.grab_data
    dino_data = []
    @f.each do |line|
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
      "no" => "",
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
  VALID_NAME = lambda do |name|
    raise InvalidDataError, "Name is invalid." unless name.alpha?
  end

  VALID_PERIOD = lambda do |period|
    raise InvalidDataError, "Period is invalid." unless period.alpha?
  end

  VALID_CONTINENT = lambda do |continent|
    raise InvalidDataError, "Continent is invalid." unless continent.alpha?
  end

  VALID_DIET = lambda do |diet|
    raise InvalidDataError, "Diet is invalid." unless diet.alpha?
  end

  VALID_WEIGHT = lambda do |weight|
    unless weight.number? || weight.length == 0
      raise InvalidDataError, "Weight is invalid."
    end
  end

  VALID_WALKING = lambda do |walking|
    raise InvalidDataError, "Walking is invalid." unless walking.alpha?
  end

  DISPATCHER = {
    "name" => VALID_NAME,
    "period" => VALID_PERIOD,
    "continent" => VALID_CONTINENT,
    "diet" => VALID_DIET,
    "weight" => VALID_WEIGHT,
    "walking" => VALID_WALKING,
  }

  def self.valid_row?(row)
    row.each { |k, v| DISPATCHER[k].call(v) if DISPATCHER.include?(k) }
    true
  end

  def self.valid_data?(data)
    data.each { |row| self.valid_row?(row) }
    true
  end
end
