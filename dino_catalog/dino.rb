require 'csv'
require 'json'


class Dinosaurs

  attr_accessor :csv_1, :csv_2,  :final_csv

  def initialize(csv1_path, csv2_path)

    @csv_1 = csv_reader(csv1_path)
    @csv_2 = csv_reader(csv2_path)

    # before starting merge modify csv2 for diet values
    @csv_2.each do |row|
      row['diet'] = row['diet'] == 'Yes' ? 'Carnivore' : nil
    end

    # merge csv into 1
    # pass array and return hash for each row.
    @final_csv =[@csv_1, @csv_2].flat_map(&method(:csv_to_hash_array))
  end

  def csv_reader(csv_path)
    CSV.read(csv_path, headers: true, :header_converters => lambda { |h| header_changer(h) })
  end

  def header_changer(header)
    case header
      when 'Genus'
        header.sub('Genus', 'name')
      when 'Carnivore'
        header.sub('Carnivore', 'diet')
      when 'WEIGHT_IN_LBS'
        header.sub('WEIGHT_IN_LBS', 'weight')
      else header.downcase
    end
  end

  def csv_to_hash_array(csv)
    csv.to_a[1..-1].map do |row|
      Hash[csv.headers.zip(row)]
    end
  end

  def search
    strHash = {}
    arrARGV = ARGV.map(&:downcase)
    if arrARGV.length ==1
      k,v = arrARGV[0].split('.')
      case
        when k == 'facts'
          search_facts(v)
        when k == 'collection'
          csv_print(v)
        when k == 'json'
          puts final_csv.map { |o| Hash[o.each_pair.to_a] }.to_json
        when k == 'hashsearch'
          multiple_search(eval(v.gsub(':','=>')))
        else
          strHash[k] = v
          multiple_search(strHash)
      end
    else
      arrARGV.each.reject{ |s| s=='and' }.each { |str| k, v = str.split('.')
                                                strHash[k] = v
                                               }
      multiple_search(strHash)
    end
  end


  def multiple_search(search_hash)
    matches = final_csv.select do |row|
      match = true
      search_hash.keys.each do |key|
        #puts is_row_match(row, search_hash, key)
        match = match && is_row_match(row, search_hash, key)
      end
      match
    end
    puts matches.map{|h| h['name']}
  end

  def is_row_match(row, search_hash, key)
    if key == 'size' && search_hash[key] == 'big'
      row['weight'].to_i > 2000
    elsif key == 'size' && search_hash[key] == 'small'
      row['weight'].to_i <= 2000
    else
      #we have a requirement to count Insectivore and Piscivore in Carnivore so add in
      if row[key] == 'Insectivore' || row[key] == 'Piscivore'
        row[key] = 'Carnivore, '+ row[key]
      end
      (row[key].to_s.downcase || '').include?(search_hash[key])
    end
  end

  def search_facts(name)
    matches2 = final_csv.select{|a| a['name'].to_s.downcase == name}
    facts_hash = Hash[*matches2.collect{|h| h.to_a}.flatten]
    facts_hash.each { |key, value| unless value.nil?
                                     puts "#{key}: #{value}"
                                     end }
  end

  def csv_print(filename)
    case filename
      when 'african_dinosaur_export'
        puts csv_2['name']
      when 'dinodex'
        puts csv_1['name']
    end
  end
end

if ARGV.length == 0

  puts 'You can search on following conditions'
  puts ''
  puts '#column criteria search'
  puts '  walking.biped'
  puts '  diet.Carnivore'
  puts '  period.Cretaceous'
  puts '  size.small'
  puts '  size big'
  puts ''
  puts '#multiple conditions AND search'
  puts '  walking.biped and diet.Carnivore'
  puts "  diet.carnivore and walking.biped and period.Cretaceous and continent.'north America'"
  puts ''
  puts '#Dinosaurs facts search'
  puts '  facts.Albertosaurus'
  puts ''
  puts '#collection print'
  puts '  collection.dinodex'
  puts '  collection.african_dinosaur_export'
  puts ''
  puts '#hashsearch'
  puts " ruby dino.rb hashsearch.\"{'walking': 'Biped', 'continent': 'Europe'}\""
  puts ''
  puts '#json print'
  puts '  json.export'
  puts ''
  exit 1
end

dino = Dinosaurs.new('dinodex.csv', 'african_dinosaur_export.csv')
dino.search