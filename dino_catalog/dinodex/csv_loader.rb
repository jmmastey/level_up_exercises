require "csv"

module Dinodex
  class CSVLoader
    # Hash of {header => default_value} to place into all rows
    attr_accessor :default_values
    attr_accessor :path

    def initialize(path = nil, default_values = {})
      @path, @default_values = path, default_values
    end

    # Process CSV file; create and yield each dinosaurs to the given block
    def read(path = nil, default_values = nil)
      raise AgumentError, "Missing input file" unless path ||= @path

      @csvreader = CSV.foreach(path, @@csv_parser_options) do |csvrow|
        yield make_dinosaur(csvrow, default_values || @default_values)
      end
    end

    # Install a custom CSV field converter
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

    # Install a customer CSV header converter
    CSV::HeaderConverters[:dinodex_rename] = lambda do |header|
      case (header = header.downcase.to_sym)
        when :genus then :name
        when :weight_in_lbs then :weight
        else header
      end
    end

    protected

    @@csv_parser_options = {
      headers: true,
      return_headers: false,
      header_converters: :dinodex_rename,
      converters: [:dinodex_csv],
    }

    def make_dinosaur(csvrow, default_values)
      taxon = csvrow.delete(:name).last
      attrs = extract_csvrow_data(csvrow)
      apply_default_values(attrs, default_values)
      determine_diet(attrs)
      Dinosaur.new(taxon, attrs)
    end

    # These CSV headers are translated to names the Dinosaur class recognizes
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
      attrs
    end

    def apply_default_values(attrs, default_values)
      default_values.each { |hdr, value| attrs[hdr] ||= value }
    end

    def determine_diet(attrs)
      # delete :carnivore because it's only useful to determine missing diet
      attrs[:diet] ||= case (attrs.delete(:carnivore) || '').downcase
                         when "yes" then Diet::UNSPECIFIED_CARNIVORE
                         when "no"  then Diet::UNSPECIFIED_NONCARNIVORE
                         else nil
                       end
    end
  end
end
