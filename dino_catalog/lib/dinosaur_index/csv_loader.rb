require "csv"

module DinosaurIndex
  class CSVLoader
    attr_accessor :default_field_values
    attr_accessor :path

    def initialize(path = nil, default_field_values = {})
      @path, @default_field_values = path, default_field_values
    end

    def read(path = nil, default_field_values = @default_field_values)
      raise AgumentError, "Missing input file" unless path ||= @path

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
      field_converter(:weight) { |v| puts "V IS #{v}"; v.to_i },
      field_converter(:period) { |v| TimePeriod.decode_instance_token(v) },
      field_converter(:diet) { |v| Diet.decode_instance_token(v) },
      field_converter(:walking) { |v| Posture.decode_instance_token(v) },
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

    def make_dinosaur(csv_row, default_field_values)
      taxon = csv_row.delete(:name).last
      csv_row_data = extracted_csv_row_data(csv_row)
      apply_default_field_values(csv_row_data, default_field_values)
      determine_diet(csv_row_data)
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

    def extracted_csv_row_data(csv_row)
      row_data = csv_row.headers.map do |hdr|
        [remapped_header(hdr), csv_row[hdr]]
      end

      Hash[row_data]
    end

    def apply_default_field_values(csv_row_data, default_field_values)
      default_field_values.each { |hdr, value| csv_row_data[hdr] ||= value }
    end

    def determine_diet(csv_row_data)
      is_a_carnivore = 
        (csv_row_data.delete(:carnivore) || '').casecmp('yes') == 0

      csv_row_data[:diet] ||= if is_a_carnivore
                              then Diet::UNSPECIFIED_CARNIVORE
                              else Diet::UNSPECIFIED_NONCARNIVORE
                              end
    end
  end
end
