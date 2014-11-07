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
      field_converter(:diet) { |v| normalize_field_value(v) },
      field_converter(:walking) { |v| normalize_field_value(v) },
    ]

    HEADERCONVERTERS =
    [
      ->(header) { header },
      ->(header) { header.downcase.gsub(' ', '_') },
      ->(header) { header == 'genus' ? 'name' : header },
      ->(header) { header == 'weight_in_lbs' ? 'weight' : header },
      ->(header) { header.to_sym },
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
      csv_field_value.downcase.to_sym unless csv_field_value.nil?
    end

    def decode_time_period(csv_row)
      period_strings = /(?:(\w+)\s+)?(\w+)/.match(csv_row[:period])
      (early_or_late, period) =
        period_strings[1, 2].map { |val| self.class.normalize_field_value(val) }
      csv_row[:time_period] = period
      csv_row[:part_of_period] = early_or_late
    end

    def make_dinosaur(csv_row, default_field_values)
      taxon = csv_row.delete(:name).last
      csv_row_data = csv_row.to_hash
      decode_time_period(csv_row_data)
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
