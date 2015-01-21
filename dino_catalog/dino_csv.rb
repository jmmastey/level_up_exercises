require 'csv'
require './dinosaur.rb'

class DinoCsv
  attr_accessor :results

  CONTINENTS = ['ASIA', 'AFRICA', 'NORTH AMERICA', 'SOUTH AMERICA', 'ANTARCTICA', 'EUROPE', 'AUSTRALIA']

  def initialize(file_paths = [])
    @file_paths = file_paths
    @results = []
    @file_paths.each do |file|
      @results <<  parse(file)
    end
  end

  def parse(file)
    parsed_data = []
    raise "The file = #{file} could not be located" unless file_exists?(file)
    CSV.foreach(file, headers: true, header_converters: :symbol) do |obj|
      data = Dinosaur.new(name: process_csv_data(obj.to_h.assoc(:name) || obj.to_h.assoc(:genus)),
                          period: process_csv_data(obj.to_h.assoc(:period)),
                          continent: process_csv_data(obj.to_h.assoc(:continent)) || assign_continent_from_file_name(file),
                          diet: process_csv_data(obj.to_h.assoc(:diet) || obj.to_h.assoc(:carnivore)),
                          weight: process_csv_data(obj.to_h.assoc(:weight_in_lbs) || obj.to_h.assoc(:weight)),
                          ambulation: process_csv_data(obj.to_h.assoc(:walking)),
                          description: process_csv_data(obj.to_h.assoc(:description)))

      parsed_data << data.to_hash
    end
    parsed_data
  end

  def process_csv_data(obj)
    if obj.nil?
      return nil
    else
      case obj[0]
        when :continent
          FormatCsvData.new(obj[1]).to_lowercase unless obj[1].nil?
        when :carnivore
          (obj[1].downcase == 'yes' ? 'carnivore' : 'non-carnivore') unless obj[1].nil?
        when :weight_in_lbs || :weight
          FormatCsvData.new(obj[1]).to_integer unless obj[1].nil?
        else # :name, :genus, :period, :diet, :description
          FormatCsvData.new(obj[1]).to_lowercase unless obj[1].nil?
      end
    end
  end

  def file_exists?(file)
    File.file?(file)
  end

  def assign_continent_from_file_name(file)
    result = CONTINENTS.select do |continent|
      /#{continent}/i.match file
    end
    FormatCsvData.new(result[0].to_s).to_lowercase unless result.empty?
  end
end

class FormatCsvData
  attr_accessor :data

  def initialize(data)
    @data = data
  end

  def to_integer
    unless is_i?
      raise "You must pass a numeric string!"
    end
    @data.to_i
  end

  def to_lowercase
    @data.downcase
  end

  def is_i?
    !Float(@data).nil? rescue false
  end
end
