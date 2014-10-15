require "csv"

module Dinodex
  class CSVLoader

    # Hash of {header => default_value} to place into all rows
    attr_accessor :default_values
    attr_accessor :path

    def initialize(path = nil, default_values = {})
      @path, @default_values = path, default_values
    end

    def read(path = nil, default_values = nil)
      path ||= @path or raise AgumentError.new("Missing input file")

      @csvreader = CSV.foreach(path,
                               headers: true,
                               return_headers: false,
                               header_converters: :dinodex_rename,
                               converters: [:dinodex_csv]) do |csvrow|
        yield make_dinosaur(csvrow, default_values || @default_values)
      end
    end

    protected

    def extract_other_information(csvrow)
      other = {}
      other[:description] = csvrow[:description] if csvrow[:description]
      other[:continent] = csvrow[:continent] if csvrow[:continent]
      other[:diet] = csvrow[:diet] || case csvrow[:carnivore].casecmp("yes")
                                      when 0 then Diet::UNSPECIFIED_CARNIVORE
                                      else Diet::UNSPECIFIED_NONCARNIVORE
                                      end
      other
    end

    def make_dinosaur(csvrow, default_values)
      default_values.each { |header, value| csvrow[header] = value }
      other = extract_other_information(csvrow)
      taxon, period, weight, ambulation = 
        [:name, :period, :weight, :walking].map { |field| csvrow[field] }

      Dinosaur.new(taxon, period, weight, ambulation, other)
    end

    CSV::Converters[:dinodex_csv] = lambda do |fieldval, fieldinfo|
      return nil if fieldval.nil?

      case fieldinfo.header
      when :period then TimePeriod.decode_instance_token(fieldval)
      when :diet then Diet.decode_instance_token(fieldval)
      when :weight then fieldval.to_i
      when :walking then Ambulation.decode_instance_token(fieldval)
      else fieldval
      end
    end

    CSV::HeaderConverters[:dinodex_rename] = lambda do |header|
      case (header = header.downcase.to_sym)
      when :genus then :name
      when :weight_in_lbs then :weight
      else header
      end
    end
  end
end

