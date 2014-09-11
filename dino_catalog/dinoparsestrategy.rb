class DinoParseStrategy
  attr_reader :file_name, :dino_parser

  def initialize(values)
    @file_name = values[:file_name]
    @dino_parser = values[:dino_parser]
  end

  def parse_dinos
    @dino_parser.parse(file_name)
  end
end
