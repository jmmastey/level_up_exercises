require "csv"

module Dinodex
  module CSVLoader
    extend self

    def load(io)
      @csvreader = CSV.foreach(io,
                               headers: true,
                               return_headers: true,
                               header_converters: 
                                [:downcase, :symbol, :dinodex_rename],
                               converters: [:dinodex_csv]) do |csvrow|
        yield make_dinosaur(csvrow)
      end
    end

    protected

    def extract_other_information(csvrow)

      other = {}
      other[:description] = csvrow[:description] if csvrow[:description]
      other[:continent] = csvrow[:continent] if csvrow[:continent]
      other[:diet] = csvrow[:diet] || case csvrow[:carnivore].casecmp("yes")
                                      when 0 then Diet.UNSPECIFIED_CARNIVORE
                                      else Diet.UNSPECIFIED_NONCARNIVORE
                                      end
      other
    end

    def make_dinosaur(csvrow)

      other = extract_other_information(csvrow)
      taxon, period, weight, ambulation = 
        [:name, :period, :weight, :ambulation].map { |field| csvrow[field] }

      Dinosaur.new(taxon, period, weight, ambulation, other)
    end

    CSV::Converters[:dinodex_csv] = lambda do |fieldval, fieldinfo|
      case fieldinfo.header
      when :period then TimePeriod.decode(fieldval)
      when :diet then Diet.decode(fieldval)
      when :weight then fieldval.to_i
      when :walking then Ambulation.decode(fieldval)
      else fieldval
      end
    end

    CSV::HeaderConverters[:dinodex_rename] = lambda do |header, fieldinfo|
      case header
      when :genus then :name
      when :weight_in_lbs then :weight
      end
    end
  end
end

