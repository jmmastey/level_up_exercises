#!/usr/bin/ruby
#
# dinosaur_catalog.rb
#
# Fri Oct  3 11:56:12 CDT 2014
# Jonathan Marks (jmarks1@enova.com)
#
# Implements CLI application as solution to "dinodex" leveluprails exercise. Represents dinosaurs internally
# as CSV::Row objects with # no higher-level data structure. Not designed to export API for use in other 
# software.
#

require "csv"
require "optparse"

class DinoTable

  attr_reader :csv_table

  # Field names encounted that are keys in this hash are translated to corresponding values
  @@header_map = {
    'genus'           => 'name',
    'weight_in_lbs'   => 'weight',
  }

  # Diet type tokens mapping true in this hash are recognized as carnivorous diets
  @@carnivorous_diets = {
    'insectivore' => true,
    'piscivore' => true,
    'carnivore' => true
  }


  # fix_dino_table_row
  #
  # Parameters
  #   row (CSV::Row) A newly read row from CSV file
  # Returns: (CSV::Row) A CSV row, possibly modified from the row passed as input
  # Normalize a CSV row to ensure all known data are accounted and in proper form for query.
  # NOTE: A CSV field converter won't suffice because these actions use data from multiple
  # fields at once.
  def fix_dino_table_row(row)

    # Complete the "carnivore" field based on diet if incomplete and we know the diet
    row[:carnivore] =
      !!@@carnivorous_diets[row.field(:diet)] unless row.header?(:carnivore)

    # Complete "diet" field w/generic info if we only know whether dino is a carnivore
    #
    # NOTE: ASK CUSTOMER WHETHER THESE GENERIC ASSUMPTIONS ARE DESIRABLE AND CORRECT
    #
    row[:diet] =
      row.field(:carnivore) ? "carnivore" : "herbivore" unless row.header?(:diet)

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

          ->(fval, finfo) {
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
          }
        ]
      }) { |new_row|

        # Accumulate the new fixed up rows into a CSV table
        @csv_table << fix_dino_table_row(new_row)
      }
  end


  # initialize
  #
  # Parameters
  #   filenames (variadic list of strings) - List of filenames of CSV input files to read
  # Constructs a DinoTable, optionally initializing with data from CSV input files
  def initialize(*filenames)

    # Accumulator for full dinosaur data set
    @csv_table = CSV::Table.new([])

    filenames.each { |datafile| read_dino_csv(datafile) }

    @csv_table.each { |r| puts r.inspect; puts "\n" }
  end 
end     # class DinoTable


# Implements the main program; command-line interface that identfies input data files and
# selects filters to apply to dinosaur data constructed from input files.
class DinoDex

  # Initialized with dinosaur information after construction
  attr_reader :dino_table

  def initialize

    @filters = [->(csvrow) { true }]
    @dino_table = DinoTable.new
  end

  # parse_options
  #
  # Parameters
  #   options (Array of Strings) - List of command-line options (defaults to ARGV)
  # Configures the DinoDex by interpreting command-line arguments in an arg vector
  def parse_options(options = ARGV)

    optparser = OptionParser.new { |opts|

      opts.banner = "Usage #{opts.program_name} [-f <input_file>]+ [-l|-s] [-c|-C] [-b|-q] [-p <period>]"
      opts.separator ""
      opts.separator "Description of options:"
      
      opts.on("-f", "--input-file filename", "Use data from a properly-formatted CSV input file") { |fname| 
        @dino_table.read_dino_csv(fname) 
      }

      opts.on("-l", "--large", "Select only large dinosaurs") {
        @filters << ->(csvrow) { (! (w = csvrow[:weight]).nil?) && (w > 4000) }
      }

      opts.on("-s", "--small", "Select only small dinosaurs") {
        @filters << ->(csvrow) { (! (w = csvrow[:weight]).nil?) && (w <= 4000) }
      }

      opts.on("-c", "--carnivores", "Select only carnivorous beasts") {
        @filters << ->(csvrow) { (! (c = csvrow[:carnivore]).nil?) && c }
      }

      opts.on("-C", "--non-carnivorous", "Select only non-carnivorous beasts") {
        @filters << ->(csvrow) { (! (c = csvrow[:carnivore]).nil?) && !c }
      }

      opts.on("-b", "--bipedal", "Select only bipeds") {
        @filters << ->(csvrow) { (! (w = csvrow[:walking]).nil?) && (w == "biped") }
      }

      opts.on("-q", "--quadrupedal", "Select only quadrupeds") {
        @filters << ->(csvrow) { (! (w = csvrow[:walking]).nil?) && (w == "biped") }
      }

      opts.on("-p", "--period [period]", "Select dinosaurs from periods matching expression") { |expr|
        @filters << ->(csvrow) { (! (p = csvrow[:period]).nil?) && (p =~ /#{expr}/i) }
      }

      opts.on_tail("-h", "--help", "Show option summary") {
        puts opts
        exit 1
      }
    }
  
    begin

      optparser.parse!(options)
    rescue Exception => ex
    
      puts ex.message + "\n"
      puts optparser
      exit 1
    end
  end

  # write_field
  #
  # Parameters
  #   csvrow (CSV::Row) - A CSV::Row describing a dinosaur
  #   fieldname (symbol) - CSV row field identifier
  #   label (string) - Thingie to print in front of field value to identify the data to user
  # Writes to stdout a formatted description of a specified dinosaur attribute denoted in the CSV::Row
  def write_field(csvrow, fieldname, label)

    puts "#{label}: #{csvrow[fieldname]}\n" if csvrow.include?(fieldname) && ! csvrow[fieldname].nil?
  end


  # print_dinosaur
  #
  # Parameters
  #   csvrow (CSV::Row) - A CSV::Row describing a dinosaur
  # Writes to stdout a formatted description of all the dinosaurs attributes (we care about) in the CSV::Row
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
  # Applies filters to the list of all known dinosaurs and prints to stdout a formatted list of all that 
  # survive the filter criteria
  def print_dinosaurs

    # Ought to do this another way that shortcuts filter evaluation when one fails
    @dino_table.csv_table.delete_if { |csvrow|
      ! @filters.inject(true) { |keep, filter_method| keep && filter_method.call(csvrow) }
    }.each { |surviving_csvrow|
      print_dinosaur(surviving_csvrow)
      puts
    }
  end
end

#
# Main program begins
#

d = DinoDex.new
d.parse_options
d.print_dinosaurs
