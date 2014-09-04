require './dino'
require './dinotoken'
require './matching'

require 'csv'

class CSV::Table
  def map(&blk)
    a = []
    self.each do |row|
      a.push(blk.call(row))
    end
    a
  end
end


class DinoParser
  @@csv_opts = {
    :headers => true,
    :header_converters => :downcase,
    :converters => :integer
  }
  def parse(data)
    data = CSV.read(data,@@csv_opts) if data.is_a? String
    return data.map do |row|
      Dinosaur.new(row.to_hash)
    end
  end
end

class AfroDinoParser
  @@csv_opts = {
    :headers => true,
    :header_converters => :downcase,
    :converters => :integer
  }
  def parse(data)
    data = CSV.read(data,@@csv_opts) if data.is_a? String
    return data.map do |row|
      Dinosaur.new(row.to_hash)
    end
  end
end

class DinoTokenParser
  def parse(command)
    raw_tokens = command.split(/;\s*/)
    raw_tokens.map do |raw_token|
      parts = raw_token.split(/\s+/)
      tag = parts[0]
      Match(tag, nil, {
        'AND' => lambda {AndToken.new(parts)},
        'SORT' => lambda {SortToken.new(parts)}
      })
    end
  end
end
