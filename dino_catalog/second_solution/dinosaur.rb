class Dinosaur
  SPECIAL_CASE_CSV_COLUMN_HEADERS = ["carnivore"]
  RECOGNIZED_CSV_COLUMN_HEADERS = ["name", "genus", "weight", "walking", "period", "diet", "weight_in_lbs", "locomotion"]

  attr_reader :name, :weight, :diet, :locomotion, :period, :additional_info
  def initialize(args)
    @name             =   args[:name]
    @weight           =   args[:weight]
    @diet             =   args[:diet]
    @locomotion       =   args[:locomotion]
    @period           =   args[:period]
    @additional_info  =   args[:additional_info]
  end

########  class methods  ########

  def self.from_csv_row(csv_row)
    Dinosaur.new( Dinosaur.construct_args_from_csv(csv_row) )
  end

  def self.construct_args_from_csv(csv_table_row)
    csv_table_row.each_with_object({}) do |data, arg|
      column_header = data[0]
      cell_data = data[1]
      if SPECIAL_CASE_CSV_COLUMN_HEADERS.include?(column_header)
        Dinosaur.add_special_case_data_to_arg(column_header, cell_data, arg)
      elsif RECOGNIZED_CSV_COLUMN_HEADERS.include?(column_header)
        Dinosaur.add_recognized_data_to_arg(column_header, cell_data, arg)
      else
        Dinosaur.add_unrecognized_data_to_arg(column_header, cell_data, arg)
      end
    end
  end

  def self.add_unrecognized_data_to_arg(column_header, cell_data, arg)
    arg[:additional_info] = {} unless arg[:additional_info]
    arg[:additional_info][column_header] = cell_data
  end

  def self.add_special_case_data_to_arg(column_header, cell_data, arg)
    case column_header
    when "carnivore"
      recognized_header = "diet"
      recognized_data = Dinosaur.special_case_carnivore_data(cell_data)
      Dinosaur.add_recognized_data_to_arg(recognized_header, recognized_data, arg)
    end
  end

  def self.special_case_carnivore_data(cell_data)
    if cell_data.downcase == "no"
      "herbivore"
    else      
      "carnivore"
    end
  end

  def self.add_recognized_data_to_arg(column_header, cell_data, arg)
    arg[Dinosaur.attribute_from_recognized_csv_header(column_header)] = cell_data
  end

  def self.attribute_from_recognized_csv_header(column_header)
    case column_header
    when "name", "genus"
      :name
    when "weight", "weight_in_lbs"
      :weight
    when "locomotion", "walking"
      :locomotion
    when "period"
      :period
    when "diet"
      :diet
    end
  end
end