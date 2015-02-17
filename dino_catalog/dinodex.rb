require 'json'
load 'formatter.rb'

# Class DinoCatalog will have dino collection and search api
class DinoCatalog
  SIZE_SMALL = 2000

  def initialize(*filepaths)
    @dino = []
    filepaths.each do |fp|
      @dino += Formatter.format(fp).map(&:to_hash)
    end
  end

  def hash_query(raw_input)
    query_each = []
    if raw_input.include? 'where'
      query = raw_input.split('where')[1].split('and')
      query.each { |q| query_each += q.split('=') }
      query_each = query_each.collect(&:strip)
    else
      query_each = raw_input.gsub!(/[^0-9A-Za-z]/, ' ').split(' ')
    end
    Hash[*query_each.flatten]
  end

  def search(raw_input, print_format)
    matches = search_dino(hash_query(raw_input))
    print_dino(matches, print_format)
  rescue
    puts 'Query is not well formatted. Please check.'
  end

  def print_dino(matches, print_format)
    if print_format == 'json'
      puts matches.to_json
    else
      matches.each do |x|
        match = Hash[*x.flatten].sort_by(&:first)
        match.each { |k, v| puts "#{k}: #{v}" unless v.nil? || k == 'source' }
        puts ''
      end
    end
  end

  def search_dino(search_hash)
    @dino.select do |row|
      match = true
      search_hash.keys.each do |key|
        match &&= row_match?(row, search_hash, key)
      end
      match
    end
  end

  def row_match?(row, search_hash, key)
    if %w(big small).include?(search_hash[key].downcase)
      row_size_match?(row, search_hash, key)
    elsif (search_hash[key].downcase).include?('carnivore')
      row_carnivore_match?(row, key)
    else
      (row[key].to_s.downcase || '').include?(search_hash[key].downcase)
    end
  end

  def row_size_match?(row, search_hash, key)
    if search_hash[key] == 'big'
      row['weight'].to_i > SIZE_SMALL
    elsif search_hash[key] == 'small'
      row['weight'].to_i <= SIZE_SMALL
    end
  end

  def row_carnivore_match?(row, key)
    %w(carnivore insectivore piscivore).include?(row[key].downcase)
  end
end
