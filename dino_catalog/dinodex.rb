require 'csv'
require 'json'

require_relative 'query_chainer.rb'
require_relative 'dino_data_parse.rb'
require_relative 'dino_data_parse_african.rb'

class DinoDex
  attr_accessor :data

  def initialize
    @data = []
    @data += DinoDataParser.new('dinodex.csv').dinos
    @data += DinoDataParserAfrican.new('african_dinosaur_export.csv').dinos
  end

  def all
    QueryChainer.new(@data)
  end

  def where(*args)
    QueryChainer.new(@data).where(*args)
  end

  def limit(args)
    QueryChainer.new(@data).limit(args)
  end

  def sort(args)
    QueryChainer.new(@data).sort(args)
  end

  def to_json
    all.to_json
  end

  def inspect
    all.pretty
  end
end
