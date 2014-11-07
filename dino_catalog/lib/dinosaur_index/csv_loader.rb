require "csv"

module DinosaurIndex
  class CSVLoader
    attr_accessor :default_field_values
    attr_accessor :path

    def initialize(path = nil, default_field_values = {})
      @path, @default_field_values = path, default_field_values
    end

    def read(path = nil, default_field_values = @default_field_values)
      raise ArgumentError, "Missing input file" unless path ||= @path

      @csvreader = CSV.foreach(path, csv_parser_options) do |csv_row|
        yield make_dinosaur(csv_row, default_field_values)
      end
    end

    protected

    def self.field_converter(for_header)
      lambda do |fieldval, fieldinfo|
        return nil if fieldval.nil?
        fieldinfo.header == for_header ? (yield fieldval) : fieldval
      end
    end

    FIELDCONVERTERS =
    [
      field_converter(:weight) { |v| v.to_i },
      field_converter(:period) { |v| normalize_field_value(v) },
      field_converter(:diet) { |v| normalize_field_value(v) },
      field_converter(:walking) { |v| normalize_field_value(v) },
    ]

    HEADERCONVERTERS =
    [
      lambda { |header| header },
      lambda { |header| header.downcase.gsub(' ', '_') },
      lambda { |header| header == 'genus' ? 'name' : header },
      lambda { |header| header == 'weight_in_lbs' ? 'weight' : header },
      lambda { |header| header.to_sym }
        # Conversion to symbol MUST BE LAST (see csv.rb #convert_fields)
    ]

    def csv_parser_options
      {
        headers: true,
        return_headers: false,
        header_converters: HEADERCONVERTERS,
        converters: FIELDCONVERTERS,
      }
    end

    def self.normalize_field_value(csv_field_value)
      csv_field_value.downcase.to_sym
    end

    def self.decode_time_period(time_period_string)
      period_strings = /(?:(\w+)\s+)?(\w+)/.match(time_period_string)
      (early_or_late, period) =
        period_strings[1].to_sym, period_strings[2].to_sym
    end

    def make_dinosaur(csv_row, default_field_values)
      taxon = csv_row.delete(:name).last
      csv_row_data = remapped_and_resolved_row_data(csv_row)
      apply_default_field_values(csv_row_data, default_field_values)
      Dinosaur.new(taxon, csv_row_data)
    end

    # These CSV headers are translated to names the Dinosaur class recognizes
    HEADER_REMAPPING = {
      genus: :name,
      weight_in_lbs: :weight,
      walking: :posture,
      period: :time_period,
    }

    def remapped_header(header)
      HEADER_REMAPPING[header] || header
    end

    def remapped_and_resolved_row_data(csv_row)
      row_data = csv_row.headers.map do |hdr|
        [remapped_header(hdr), csv_row[hdr]]
      end

      row_data = Hash[row_data]
      determine_diet(row_data) 
      row_data
    end

    def determine_diet(row_data)
      row_data[:diet] ||= 
        row_data[:carnivore].casecmp('yes') == 0 ? :carnivore : :herbivore
    end

    def apply_default_field_values(csv_row_data, default_field_values)
      default_field_values.each { |hdr, value| csv_row_data[hdr] ||= value }
    end
  end
end
