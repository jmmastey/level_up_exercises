RECOGNIZED_CSV_COLUMN_HEADERS = ["name", "genus", "carnivore", "weight", "walking", "period", "diet", "weight_in_lbs"]

class DinoSaur
  attr_reader :name, :weight, :diet, :locomotion, :period, :additional_info
  def initialize(args)
    @name = args[:name]
    @weight = args[:weight]
    @diet = args[:diet]
    @locomotion = args[:locomotion]
    @period = args[:period]
    @additional_info = args[:additional_info]
  end

  def is_big?
    self.weight >= 4000
  end

  def is_carnivore?
    ["piscivore", "carnivore", "insectivore"].include?(self.diet.downcase)
  end

  def is_biped?
    self.locomotion.downcase == "biped"
  end

  # def existing_attributes
  #   rtn
  # end

  def to_s
    rtn = []
    self.instance_variables.each do |attribute|
      next if !self.instance_variable_get(attribute)
      if attribute == :@additional_info 
        additional_info.each do |k, v|
          rtn << "#{k}: #{v}"
        end
      else
        rtn << "#{attribute.to_s[1..-1]}: #{self.instance_variable_get(attribute)}"
      end
    end

    rtn.compact.join(", ") + "\n\n"
  end

  ###  class methods  ####

  def self.construct_arguments(csv_table_row)
    rtn = {}
    rtn[:name] = DinoSaur.parse_name(csv_table_row)
    rtn[:weight] = DinoSaur.parse_weight(csv_table_row)
    rtn[:diet] = DinoSaur.parse_diet(csv_table_row)
    rtn[:locomotion] = DinoSaur.parse_locomotion(csv_table_row)
    rtn[:period] = DinoSaur.parse_period(csv_table_row)
    rtn[:additional_info] = DinoSaur.parse_additional_info(csv_table_row)
    rtn
  end

  def self.general_parser(possible_headers, csv_table_row)
    header = csv_table_row.headers
    possible_headers.each do |possible_header|
      return csv_table_row[possible_header] if header.include?(possible_header)
    end
  end

  def self.parse_name(csv_table_row)
    possible_headers = ["name", "genus"]
    DinoSaur.general_parser(possible_headers, csv_table_row)
  end

  def self.parse_weight(csv_table_row)
    possible_headers = ["weight", "weight_in_lbs"]
    DinoSaur.general_parser(possible_headers, csv_table_row)
  end

  def self.parse_diet(csv_table_row)
    header = csv_table_row.headers
    return csv_table_row["diet"] if header.include?("diet")
    if header.include?("carnivore")
      if csv_table_row["carnivore"]
        "carnivore"
      else
        "herbivore"
      end
    end
  end

  def self.parse_locomotion(csv_table_row)
    possible_headers = ["walking"]
    DinoSaur.general_parser(possible_headers, csv_table_row)
  end

  def self.parse_period(csv_table_row)
    possible_headers = ["period"]
    DinoSaur.general_parser(possible_headers, csv_table_row)
  end

  def self.parse_additional_info(csv_table_row)
    unrecognized_fields = csv_table_row.headers - RECOGNIZED_CSV_COLUMN_HEADERS
    if !unrecognized_fields.empty?
      additional_info = {}
      unrecognized_fields.each do |header|
        additional_info[header] = csv_table_row[header]
      end  
      additional_info
    end
  end

end


args = {}
args[:name] = "Albertosaurus"
args[:weight] = 2000
args[:diet] = "Carnivore"
args[:locomotion] = "Biped"
args[:period] = "Late Cretaceous"
args[:additional_info] = {continent: "North America", description: "Like a T-Rex but smaller."}

d = DinoSaur.new(args)
puts d