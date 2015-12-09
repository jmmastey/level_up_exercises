require 'csv'
require 'json'

class DinoCatalog
  attr_accessor :data

  def initialize
    dinodex = CSVHelper.load_csv("dinodex.csv")
    african = CSVHelper.load_csv("african_dinosaur_export.csv")
    @data = merge_data(dinodex, african)
  end

  def start_filter
    @filtered ||= @data.dup
  end

  def results
    start_filter
    results = @filtered.dup
    @filtered = nil
    results
  end

  def select(&block)
    start_filter
    @filtered = @filtered.select(&block)
    self
  end

  def length
    results.length
  end

  def to_s
    results.to_s
  end

  def to_json
    JSON.generate(results)
  end

  def print
    JSON.pretty_generate(results)
  end

  def grab_bipeds
    search(:walking => "Biped")
  end

  def grab_carnivores
    search(:carnivore => true)
  end

  def grab_period(period)
    select { |item| item[:period].include? period }
  end

  def grab_heavier_than(weight)
    select { |item| (item[:weight] || 0) > weight }
  end

  def search(filters)
    filters.each do |key, value|
      select { |item| item[key] == value }
    end
    self
  end

  def merge_data(dinodex, african)
    merged = []
    dinodex.each { |entry| merged << normalize_dinodex_entry(entry) }
    african.each { |entry| merged << normalize_african_entry(entry) }
    merged
  end

  def normalize_dinodex_entry(entry)
    {
      :name => entry[:name],
      :period => entry[:period],
      :continent => entry[:continent],
      :diet => entry[:diet],
      :carnivore => get_carnivore_for_dinodex(entry[:diet]),
      :weight => entry[:weight_in_lbs],
      :walking => entry[:walking],
      :description => entry[:description],
    }
  end

  def normalize_african_entry(entry)
    {
      :name => entry[:genus],
      :period => entry[:period],
      :continent => nil,
      :diet => nil,
      :carnivore => (entry[:diet] == "Yes"),
      :weight => entry[:weight],
      :walking => entry[:walking],
      :description => nil,
    }
  end

  def get_carnivore_for_dinodex(diet)
    %w(Carnivore Pescivore Insectivore).include? diet
  end
end

module CSVHelper
  CSV::Converters[:blank_to_nil] = lambda do |field|
    field && field.empty? ? nil : field
  end

  def self.load_csv(filename)
    f = File.open(filename, "r")
    data = CSV.new(f, :headers => true, :header_converters => :symbol,
                   :converters => [:all, :blank_to_nil])
    data.to_a.map(&:to_hash)
  end
end

catalog = DinoCatalog.new
# puts catalog.data
# puts catalog.select { |item| item[:period].include? "Jurrasic"}.length
# puts catalog.grab_period("Jurassic").grab_heavier_than(2000).results.length

puts "# carnivores: #{catalog.search(:carnivore => true).length}"
puts "# get carnivores: #{catalog.grab_carnivores.length}"
puts "# herbivores: #{catalog.search(:carnivore => false).length}"
puts "# bipeds: #{catalog.grab_bipeds.length}"
puts "# Jurassic: " \
  "#{catalog.grab_period('Jurassic').grab_heavier_than(2000).length}"
puts "# Cretaceous: #{catalog.grab_period('Cretaceous').length}"
puts "# really heavy: #{catalog.grab_heavier_than(2000).length}"
puts "# really heavy carnivores: " \
  "#{catalog.grab_heavier_than(2000).grab_carnivores.length}"
puts "JSON: #{catalog.grab_heavier_than(2000).grab_carnivores.to_json}"
puts "print: #{catalog.grab_heavier_than(2000).grab_carnivores.print}"
