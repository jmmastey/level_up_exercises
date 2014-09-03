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
      Dinosaur.new(
      row.field("name"),row.field("period"), row.field("continent"),
      row.field("diet"),row.field("weight_in_lbs"),row.field("walking"),
      row.field("description")
      )
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
      diet = parse_carnivore(row.field("carnivore"))
      Dinosaur.new(
      row.field("genus"),row.field("period"),"Africa",
      diet,row.field("weight"),row.field("walking"),""
      )
    end
  end

  def parse_carnivore(str)
    (str.downcase == "yes") ? "Carnivore" : "Herbivore"
  end
end

class DinoTokenParser
  def parse(command)
    raw_tokens = command.split(':')
    raw_tokens.map do |raw_token|
      parts = raw_token.split(',')
      tag = parts[0]
      Match(tag, nil, {
        'AND' => lambda {AndToken.new(parts)},
        'SORT' => lambda {SortToken.new(parts)}
      })
    end
  end
end
