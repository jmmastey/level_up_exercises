require 'csv'
require 'pp'
class DinoCsvCleaner
  attr_accessor :csv_headers
  def initialize(csv_files)
    @csv_data = []
    @csv_headers = []
    @csv_files = csv_files
  end

  def open_file(csv_file)
    CSV.foreach(csv_file, headers: true, header_converters: :downcase) do |row|
      @csv_data << row.to_hash
      @csv_headers << row.to_hash.keys.map! { |x| x.dup.chomp }
    end
  end

  def standardize_weight
    @csv_data.each do |row|
      if row.keys.include? "weight_in_lbs"
        row["weight"] = row.delete("weight_in_lbs")
      end
    end
  end

  def standardize_diet
    @csv_data.each do |row|
      if row.keys.include? "carnivore"
        carn_status = row.delete("carnivore")
        row["diet"] = "Carnivore" if carn_status == "Yes"
      end
    end
  end

  def standardize_headers
    @csv_headers.flatten!.map! { |a| a }.uniq!.delete("weight_in_lbs")
    @csv_headers.delete("carnivore")
  end

  def standardize_keys
    standardize_headers
    standardize_weight
    standardize_diet
  end

  def create_merged_files
    CSV.open("new.csv", "w") do |out|
      out << @csv_headers
      @csv_data.each do |line|
        out << @csv_headers.map { |header| line[header] }
      end
    end
  end

  def create_standardized_file
    standardize_keys
    create_merged_files
  end

  def create_dinosaur_hash
    @csv_files.each do |c|
      open_file(c)
    end
    create_standardized_file
  end
end
