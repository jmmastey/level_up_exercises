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
      raise AgumentError, "Missing input file" unless path ||= @path

      @csvreader = CSV.foreach(path, @@csv_parser_options) do |csvrow|
        yield make_dinosaur(csvrow, default_values || @default_values)
      end
    end

    protected

    @@csv_parser_options = {
      headers: true,
      return_headers: false,
      header_converters: :dinodex_rename,
      converters: [:dinodex_csv],
    }

    def determine_general_diet(attrs)
      # delete :carnivore because it's only useful to determine diet
      attrs[:diet] ||= case (attrs.delete(:carnivore) || '').downcase
                         when "yes" then Diet::UNSPECIFIED_CARNIVORE
                         when "no"  then Diet::UNSPECIFIED_NONCARNIVORE
                         else nil
                       end
    end

    @@header_remapping = {
      genus: :name,
      weight_in_lbs: :weight,
      walking: :ambulation,
      period: :time_period,
    }

    def remap_header(header)
      @@header_remapping[header] || header
    end

    def extract_csvrow_data(csvrow)
      attrs = {}
      csvrow.headers.each { |hdr| attrs[remap_header(hdr)] = csvrow[hdr] }
      decode_time_period(attrs)
    end

    def decode_time_period(attrs)
      # Decodes strings like "cretaceous" and "late jurassic"
      matches = /(?:(\w+)\s+)?(\w+)/.match(attrs[:time_period] || '')
      attrs[:time_period] = TimePeriod.decode_instance_token(matches[2])
      attrs[:time_period_qualifier] = matches[1]
      attrs
    end

    def apply_default_values(attrs)
      default_values.each { |hdr, value| attrs[hdr] ||= value }
      attrs
    end

    def make_dinosaur(csvrow, default_values)
      taxon = csvrow.delete(:name).last
      attrs = apply_default_values(extract_csvrow_data(csvrow))
      determine_general_diet(attrs)
      Dinosaur.new(taxon, attrs)
    end

    CSV::Converters[:dinodex_csv] = lambda do |fieldval, fieldinfo|
      return nil if fieldval.nil?

      case fieldinfo.header
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
