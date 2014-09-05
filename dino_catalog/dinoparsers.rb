require './dino'
require './dinotoken'
require './matching'

require 'csv'

class CSV::Table
  def map(&blk)
    a = []
    each do |row|
      a.push(blk.call(row))
    end
    a
  end
end

class DinoParser
  @@csv_opts = {
    headers: true,
    header_converters: :downcase,
    converters: :integer
  }
  def parse(data)
    data = CSV.read(data, @@csv_opts) if data.is_a? String
    data.map do |row|
      Dinosaur.new(parse_csv_row(row.to_hash))
    end
  end

  private

  def parse_csv_row(csv_row)
    {
      name: csv_row['name'],
      period: csv_row['period'],
      continent: csv_row['continent'],
      diet: csv_row['diet'],
      walk: csv_row['walking'],
      weight: (csv_row['weight_in_lbs'] || -1),
      desc: csv_row['description']
    }
  end
end

class AfroDinoParser < DinoParser
  private

  def parse_csv_row(csv_row)
    {
      name: csv_row['genus'],
      period: csv_row['period'],
      continent: 'Africa',
      diet: csv_row['carnivore'],
      walk: csv_row['walking'],
      weight: csv_row['weight'],
      desc: ''
    }
  end
end

class DinoTokenParser
  def parse(command)
    raw_tokens = command.split(/;\s*/)
    raw_tokens.map do |raw_token|
      parts = raw_token.split(/\s+/)
      tag = parts[0]
      Match(tag,       'AND' => -> { AndToken.new(parts) },
                       'SORT' => -> { SortToken.new(parts)       })
    end
  end
end
