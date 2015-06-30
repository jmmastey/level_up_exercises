require 'csv'
require 'json'
require 'set'

class Dino
  attr_accessor :attrs

  def initialize(data)
    keys = %w(name period continent diet weight walking description)
    @attrs = Hash[*keys.zip([nil] * keys.count).flatten]
    @attrs.merge!(data)
  end

  def dino_facts
    @attrs.each do |attribute, value|
      fattr = "#{attribute.capitalize}:".ljust(20)
      fval = value.nil? ? '---' : value
      puts "#{fattr}#{fval}"
    end
    puts
  end
end

class Dinodex
  attr_accessor :dinos

  def initialize(dinos)
    @dinos = dinos || []
  end

  def index
    @dinos.each(&:dino_facts)
  end

  def compare(field, val1, val2)
    if val1.nil? || val2.nil?
      val1.__id__ <=> val2.__id__
    elsif field == 'weight'
      val1.to_i <=> val2.to_i
    else
      val1 <=> val2
    end
  end

  def lt(field, value)
    Dinodex.new(
      @dinos.select do |dino|
        next if (actual = dino.attrs[field]).nil?
        compare(field, actual.downcase, value.downcase) < 0
      end,
    )
  end

  def gt(field, value)
    Dinodex.new(
      @dinos.select do |dino|
        next if (actual = dino.attrs[field]).nil?
        compare(field, actual.downcase, value.downcase) > 0
      end,
    )
  end

  def lte(field, value)
    Dinodex.new(
      @dinos.select do |dino|
        next if (actual = dino.attrs[field]).nil?
        compare(field, actual.downcase, value.downcase) <= 0
      end,
    )
  end

  def gte(field, value)
    Dinodex.new(
      @dinos.select do |dino|
        next if (actual = dino.attrs[field]).nil?
        compare(field, actual.downcase, value.downcase) >= 0
      end,
    )
  end

  def neq(field, value)
    Dinodex.new(
      @dinos.select do |dino|
        next if (actual = dino.attrs[field]).nil?
        compare(field, actual.downcase, value.downcase) != 0
      end,
    )
  end

  def eq(field, value)
    Dinodex.new(
      @dinos.select do |dino|
        next if (actual = dino.attrs[field]).nil?
        compare(field, actual.downcase, value.downcase) == 0
      end,
    )
  end

  def like(field, value)
    Dinodex.new(
      @dinos.select do |dino|
        next if (actual = dino.attrs[field]).nil?
        actual.downcase =~ /#{value.downcase}/
      end,
    )
  end

  def search(hash)
    hash.inject(self) do |ddex, pair|
      ddex.eq(pair[0], pair[1])
    end
  end

  def sort(field)
    @dinos.sort! do |a, b|
      compare(field, a.attrs[field], b.attrs[field])
    end
    self
  end

  def json
    {
      'dinos' => @dinos.map(&:attrs),
    }.to_json
  end

  def inspect
    dinos.inspect
  end
end

class Dinoparse
  attr_reader :dinos

  def initialize(dinofile)
    dino_data = parse(dinofile)
    @dinos = dino_data.map { |dino_dat| Dino.new(dino_dat) }
  end

  def filter(d_attrs)
    to_delete = Set.new(%w(carnivore genus weight_in_lbs))
    d_attrs.delete_if { |key, _| to_delete.member?(key) }
  end

  def consolidate(d_attrs)
    d_attrs['weight'] = d_attrs['weight_in_lbs'] || d_attrs['weight']
    d_attrs['name'] = d_attrs['name'] || d_attrs['genus']

    new_diet = (d_attrs['carnivore'] ? 'Carnivore' : "Non-Carnivore")
    d_attrs['diet'] = d_attrs['diet'] || new_diet

    filter(d_attrs)
  end

  def parse(dinofile)
    dinos = CSV.parse(open(dinofile).read)
    keys = dinos.shift.map(&:downcase)
    dinos.map do |dino_attrs|
      raw_hash = Hash[*keys.zip(dino_attrs).flatten]
      consolidate(raw_hash)
    end
  end
end

#############################################################
###################      TESTS      #########################
#############################################################

# SETUP
file1 = 'dinodex.csv'
file2 = 'african_dinosaur_export.csv'

dinos1 = Dinoparse.new(file1).dinos
dinos2 = Dinoparse.new(file2).dinos

dinodex = Dinodex.new(dinos1 + dinos2).sort('name')

# QUERIES
puts "Grab all dinosaurs that were bipeds"
puts "-" * 20
dinodex.eq('walking', 'biped').index
puts

puts "Grab all the dinosaurs that were carnivores (fish and insects count)"
puts "-" * 20
dinodex.neq('diet', 'herbivore').index
puts

puts "Grab dinosaurs for specific periods (no need to \
differentiate between early and late cretaceous, btw.)"
puts "-" * 20
dinodex.like('period', 'cretaceous').index
puts

puts "Grab only big (> 2 tons) or small dinosaurs."
puts "-" * 20
dinodex.gt('weight', '4000').index
puts

puts "Just to be sure, I'd love to be able to combine criteria at will, \
even better if I can chain filter calls together"
puts "-" * 20
dinodex.like('name', 'D...o')
  .like('period', 'early')
  .like('continent', 'america').index
puts

puts "Another example of chaining."
puts "-" * 20
dinodex.like('name', 'saurus')
  .gte('weight', '10000').index
puts

puts "I would love to have a way to do (and chain) generic \
search by parameters. I can pass in a hash, and I'd like to \
get the proper list of dinos back out."
puts "-" * 20
dinodex.search('diet' => 'carnivore', 'continent' => 'europe').index
puts

puts "CSV isn't may favorite format in the world. Can \
you implement a JSON export feature?"
puts "-" * 20
puts dinodex.json
puts

# DONE
