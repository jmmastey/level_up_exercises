require 'csv'

class DinoCsvParser
  SPECIAL_CASE_CSV_COLUMN_HEADERS = ["carnivore"]
  RECOGNIZED_CSV_COLUMN_HEADERS = ["name", "genus", "weight", "walking", "period", "diet", "weight_in_lbs", "locomotion"]

  def self.from_csv_directory(dir_path = "../dino_fact_csvs")
    ary = [] # each_with_object([]) doesn't work w/ += ary
    Dir["#{dir_path}/*"].each do |file_path|
      ary += DinoCsvParser.from_csv_file(file_path)
    end
    ary
  end

  def self.from_csv_file(file_path)
    ary = []
    CSV.foreach(file_path,
                converters: :numeric,
                headers: true,
                :header_converters => lambda {|h| h.downcase}
                ) do |row|
                  ary << DinoCsvParser.dino_args_from_csv_row(row)
    end
    ary
  end

  # def self.from_json(json)
  # end

  private
  def self.dino_args_from_csv_row(csv_row)
    # I kind of want to refactor this so it can also parse a json
    csv_row.each_with_object({}) do |data, arg|
      column_header = data[0]
      cell_data = data[1]
      if SPECIAL_CASE_CSV_COLUMN_HEADERS.include?(column_header)
        DinoCsvParser.add_special_case_data_to_arg(column_header, cell_data, arg)
      elsif RECOGNIZED_CSV_COLUMN_HEADERS.include?(column_header)
        DinoCsvParser.add_recognized_data_to_arg(column_header, cell_data, arg)
      else
        DinoCsvParser.add_unrecognized_data_to_arg(column_header, cell_data, arg)
      end
    end
  end

  def self.add_special_case_data_to_arg(column_header, cell_data, arg)
    case column_header
    when "carnivore"
      recognized_header = "diet"
      recognized_data = DinoCsvParser.special_case_carnivore_data(cell_data)
    end
    DinoCsvParser.add_recognized_data_to_arg(recognized_header, recognized_data, arg)
  end

  def self.add_recognized_data_to_arg(column_header, cell_data, arg)
    arg[DinoCsvParser.attribute_from_recognized_csv_header(column_header)] = cell_data
  end

  def self.add_unrecognized_data_to_arg(column_header, cell_data, arg)
    arg[:additional_info] = {} unless arg[:additional_info]
    arg[:additional_info][column_header] = cell_data
  end

  def self.special_case_carnivore_data(cell_data)
    if cell_data.downcase == "no"
      "herbivore"
    else      
      "carnivore"
    end
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

# test = DinoCsvParser.from_directory
# puts test.count
# puts test.first
# puts test.last