#!/usr/bin/ruby
#
# dinosaur_catalog.rb
#
# Fri Oct  3 11:56:12 CDT 2014
# Jonathan Marks (jmarks1@enova.com)
#
# Implements CLI application as solution to "dinodex" leveluprails exercise.
# Represents dinosaurs internally as CSV::Row objects with # no higher-level
# data structure. Not designed to export API for use in other software.
#

require "csv"
require "optparse"

class DinoTable

  attr_reader :csv_table

  # Field names that are keys below are translated to # corresponding values
  @@header_map = {
    'genus'           => 'name',
    'weight_in_lbs'   => 'weight',
  }

  # Diet type tokens mapped true below are recognized as carnivorous diets
  @@carnivorous_diets = {
    'insectivore' => true,
    'piscivore' => true,
    'carnivore' => true
  }


  # fix_dino_table_row
  #
  # Parameters
  #   row (CSV::Row) A newly read row from CSV file
  # Returns: (CSV::Row) A CSV row, possibly modified from the row passed as
  # input Normalize a CSV row to ensure all known data are accounted and in
  # proper form for query.  NOTE: A CSV field converter won't suffice because
  # these actions use data from multiple fields at once.
  def fix_dino_table_row(row)

    # Complete "carnivore" field using diet if incomplete and we know the diet
    row[:carnivore] =
      !!@@carnivorous_diets[row.field(:diet)] unless row.header?(:carnivore)

    # Complete "diet" field w/generic info if we know whether dino is carnivore
    #
    # NOTE: ASK CUSTOMER IF THESE GENERIC ASSUMPTIONS ARE DESIRABLE AND CORRECT
    #
    row[:diet] = row.field(:carnivore) ? 
                  "carnivore" : "herbivore" unless row.header?(:diet)

    # Validate/normalize other fields? (walking, name, weight, period?)

    return row
  end


  # read_dino_csv
  #
  # Parameters(csv_stream)
  #   filename (string) - A readable CSV-formatted data file
  # Populates the internal CSV table with data found in the CSV input
  def read_dino_csv(filename)

      CSV.foreach(filename, {
        :headers          => true,
        :return_headers   => false,
        :skip_blanks      => true,
        :header_converters => [
          # Order matters; first translate and then make into symbol
          ->(header_name) { h = header_name.downcase; @@header_map[h] || h },
          :symbol
        ],
        :converters => [

          ->(fval, finfo) do
            # There are few enough fields to warrant a simple if ladder here.
            if fval.nil?
              ;
            elsif [:name, :period, :continent].include?(finfo.header)
              fval[0].upcase!
            elsif finfo.header == :carnivore
              fval = (fval.casecmp("yes") == 0)
            elsif finfo.header == :weight
              fval = fval.to_i
            else
              fval.downcase!
            end

            fval
          end
        ]
      }) do |new_row|

        # Accumulate the new fixed up rows into a CSV table
        @csv_table << fix_dino_table_row(new_row)
      end
  end


  # initialize
  #
  # Parameters
  #   filenames (variadic list of strings) - filenames of CSV inputs to read
  # Constructs a DinoTable, optionally initialized by CSV input files
  def initialize(*filenames)

    # Accumulator for full dinosaur data set
    @csv_table = CSV::Table.new([])

    filenames.each { |datafile| read_dino_csv(datafile) }

    @csv_table.each { |r| puts r.inspect; puts "\n" }
  end 
end     # class DinoTable


# Implements main program; command-line interface accepts input data files and
# selects filters to apply to dinosaur data constructed from input files.
class DinoDex

  # The lbs when we call a dinosaur large
  LARGE_WEIGHT = 4000

  # Initialized with dinosaur information after construction
  attr_reader :dino_table

  def initialize

    # Filter method list selecting  dinosaurs of interest (CLI adds # these)
    @filters = [->(csvrow) { true }]  # Default filter: Accept unconditionally

    # The container which keeps my dinosaur list
    @dino_table = DinoTable.new
  end

  # parse_options
  #
  # Parameters
  #   options (Array of Strings) - List of CLI options (defaults to ARGV)
  # Configures the DinoDex by interpreting CLI arguments in an arg vector. 
  # Each filter is written so that nil field values will fail them.
  def parse_options(options = ARGV)

    optparser = OptionParser.new do |opts|

      opts.banner = "Usage #{opts.program_name} " +
        "[-f <input_file>]+ [-l|-s] [-c|-C] [-b|-q] [-p <period>]"
      opts.separator ""
      opts.separator "Description of options:"
      
      opts.on("-f", "--input-file filename", 
          "Use data from a properly-formatted CSV input file") do |fname| 
        @dino_table.read_dino_csv(fname) 
      end

      opts.on("-l", "--large", "Select only large dinosaurs") do
        @filters << ->(csvrow) { (csvrow[:weight]) || 0) > LARGE_WEIGHT}
      end

      opts.on("-s", "--small", "Select only small dinosaurs") do
        @filters << ->(csvrow) { 
          # Distinguish nil and 0 because tiny dinosaurs can be 0 lbs
          (! (w = csvrow[:weight]).nil?) && (w <= LARGE_WEIGHT) }
      end

      opts.on("-c", "--carnivores", "Select only carnivorous beasts") do
        @filters << ->(csvrow) { csvrow[:carnivore]) }
      end

      opts.on("-C", "--non-carnivorous", 
          "Select only non-carnivorous beasts") do
        @filters << ->(csvrow) { ! ((c = csvrow[:carnivore]).nil?) || c) }
      end

      opts.on("-b", "--bipedal", "Select only bipeds") do
        @filters << ->(csvrow) { (csvrow[:walking] || '') == "biped" }
      end

      opts.on("-q", "--quadrupedal", "Select only quadrupeds") do
        @filters << ->(csvrow) { (csvrow[:walking] || '') == "quadruped" }
      end

      opts.on("-p", "--period [period]",
          "Select dinosaurs from periods matching expression") do |expr|
        @filters << ->(csvrow) { (csvrow[:period] || '') =~ /#{expr}/i }
      end

      opts.on_tail("-h", "--help", "Show option summary") do
        puts opts
        exit 1
      end
    end

    optparser.parse!(options)
  end


  # write_field
  #
  # Parameters
  #   csvrow (CSV::Row) - A CSV::Row describing a dinosaur
  #   fieldname (symbol) - CSV row field identifier
  #   label (string) - Text printed before field val identifying data to user
  # Writes to stdout a formatted description of a specified dinosaur attribute
  def write_field(csvrow, fieldname, label)

    if csvrow.include?(fieldname) && ! csvrow[fieldname].nil?
      puts "#{label}: #{csvrow[fieldname]}\n" 
    end
  end


  # print_dinosaur
  #
  # Parameters
  #   csvrow (CSV::Row) - A CSV::Row describing a dinosaur
  # Writes to stdout a formatted description of all the dinosaurs attributes
  # (we care about) in the CSV::Row
  def print_dinosaur(csvrow)

    puts "Name: #{csvrow[:name]}\n"
    write_field(csvrow, :description, "Description")
    write_field(csvrow, :period, "Period")
    write_field(csvrow, :weight, "Weight (lbs)")
    write_field(csvrow, :continent, "Continent")
    write_field(csvrow, :diet, "Diet")
    write_field(csvrow, :carnivore, "Carnivorous")
    write_field(csvrow, :walking, "Mode of Ambulation")
  end

  
  # print_dinosaurs
  #
  # Applies filters to the list of all known dinosaurs and prints to stdout 
  # a formatted list of all that survive the filter criteria
  def print_dinosaurs

    # Weed out rows for which any filter criterion fails
    @dino_table.each do |csvrow|

      unless @filters.any? { |filter_method| ! filter_method.call(csvrow) }
        print_dinosaur(csvrow)
        puts
      end
    end
  end
end

#
# Main program begins
#

begin

  d = DinoDex.new
  d.parse_options
  d.print_dinosaurs
rescue Exception => ex
    
  # Catch any kind of error h
  puts ex.message + "\n"
  puts optparser
  exit 1
end

exit 0
