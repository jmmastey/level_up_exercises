require 'CSV'

@default_dinos = CSV.read("dinodex.csv", :headers => true, :header_converters => :symbol)
@african_dinos = CSV.read("african_dinosaur_export.csv", :headers => true, :header_converters => :symbol)
@last_result = []
@chain = []

def main
  setup_chain

  loop do
    puts '1. bipeds'
    puts '2. carnivores'
    puts '3. period'
    puts '4. size'
    puts '5. name'
    puts 'c. chain'
    puts 'r. reset chain'
    puts 'p. print last result'
    puts 'q. quit'
    print 'select: '

    user_selection = gets.chomp
    puts ''

    case user_selection
    when '1'
      puts get_bipeds.join(', ')
    when '2'
      puts get_carnivores.join(', ')
    when '3'
      print 'period: '
      period = gets.chomp
      puts ''

      puts get_dinos_by_period(period).join(', ')
    when '4'
      print '(b)ig or (s)mall: '
      size = gets.chomp
      puts ''

      puts get_dinos_by_size(size).join(', ')
    when '5'
      print 'enter: '
      name = gets.chomp
      puts ''

      get_dino_by_name(name)
    when 'c'
      @chain &= @last_result unless @last_result.empty?
      puts 'chain updated'
    when 'r'
      setup_chain
      puts 'chain reset'
    when 'p'
      get_dinos_by_names(@last_result)
    when 'q'
      exit
    end

    puts ''
  end
end

def get_dino_by_name(name)
  @last_result = get_default_dino_by_name(name).concat(get_african_dino_by_name(name)) & @chain
end

def get_dinos_by_names(names)
  results = []
  names.each do |name|
    results << get_default_dino_by_name(name).concat(get_african_dino_by_name(name))
  end
  @last_result = results.flatten! & @chain
end

def get_default_dino_by_name(name)
  filter_dinos_by_and_return_by(@default_dinos, :name, name, :name)
end

def get_african_dino_by_name(name)
  filter_dinos_by_and_return_by(@african_dinos, :genus, name, :genus)
end

def setup_chain
  @default_dinos.each do |dino|
    @chain << dino[:name]
  end

  @african_dinos.each do |dino|
    @chain << dino[:genus]
  end
end

def get_dinos_by_size(size)
  @last_result = get_default_dinos_by_size(size).concat(get_african_dinos_by_size(size)) & @chain
end

def get_default_dinos_by_size(size)
  filter_dinos_by_and_return_by(@default_dinos, :weight_in_lbs, size, :name)
end

def get_african_dinos_by_size(size)
  filter_dinos_by_and_return_by(@african_dinos, :weight, size, :genus)
end

def get_bipeds
  @last_result = get_default_dinos_bipeds.concat(get_african_dinos_bipeds) & @chain
end

def get_default_dinos_bipeds
  filter_dinos_by_and_return_by(@default_dinos, :walking, 'biped', :name)
end

def get_african_dinos_bipeds
  filter_dinos_by_and_return_by(@african_dinos, :walking, 'biped', :genus)
end

def get_carnivores
  @last_result = get_default_dinos_carnivores.concat(get_african_dinos_carnivores) & @chain
end

def get_default_dinos_carnivores
  filter_dinos_by_and_return_by(@default_dinos, :diet, 'carnivore', :name)
    .concat(filter_dinos_by_and_return_by(@default_dinos, :diet, 'insectivore', :name))
    .concat(filter_dinos_by_and_return_by(@default_dinos, :diet, 'piscivore', :name))
end

def get_african_dinos_carnivores
  filter_dinos_by_and_return_by(@african_dinos, :carnivore, 'yes', :genus)
end

def get_dinos_by_period(period)
  @last_result = get_default_dinos_by_period(period).concat(get_african_dinos_by_period period) & @chain
end

def get_default_dinos_by_period(period)
  filter_dinos_by_and_return_by(@default_dinos, :period, period, :name)
end

def get_african_dinos_by_period(period)
  filter_dinos_by_and_return_by(@african_dinos, :period, period, :genus)
end

def filter_dinos_by_and_return_by(dinos, filter_by, filter_value, key)
  results = []
  dinos.each do |dino|
    case filter_by
    when :period
      filter_by_period(dino, filter_by, filter_value, results, key)
    when :name, :genus
      filter_by_name(dino, filter_by, filter_value, results, key)
    when :weight_in_lbs, :weight
      filter_by_weight(dino, filter_by, filter_value, results, key)
    else
      filter_by_walk_type(dino, filter_by, filter_value, results, key)
    end
  end

  results
end

def filter_by_period(dino, filter_by, filter_value, results, key)
  unless dino[filter_by].nil?
    period = dino[filter_by].downcase

    if period.include? filter_value.downcase
      results << dino[key]
    end
  end
end

def filter_by_name(dino, filter_by, filter_value, results, key)
  unless dino[filter_by].nil?
    name = dino[filter_by].downcase

    if name == filter_value.downcase
      results << dino[key]
      puts ''
      dino.each do |key, value|
        unless value.nil?
          puts "#{key.capitalize}: \t#{value}"
        end
      end
    end
  end

  results
end

def filter_by_weight(dino, filter_by, filter_value, results, key)
  unless dino[filter_by].nil?
    weight = dino[filter_by].downcase.to_i

    case filter_value
    when 'b'
      results << dino[key] if weight > 4000
    when 's'
      results << dino[key] if weight < 4001
    end
  end
end

def filter_by_walk_type(dino, filter_by, filter_value, results, key)
  unless dino[filter_by].nil?
    walk_type = dino[filter_by].downcase

    if walk_type == filter_value.downcase
      results << dino[key]
    end
  end
end

main
