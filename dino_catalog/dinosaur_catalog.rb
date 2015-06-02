class ParameterError < RuntimeError; end
$LOAD_PATH << '.'
require 'dinosaur'

class DinosaurCatalog
  ERROR_MESSAGE = "Please use valid search parameters"
  attr_reader :dinosaurs

  # Auto Load dinosaurs DB
  def initialize(dinosaurs)
    @dinosaurs = dinosaurs
  end

  Query = Struct.new(:function, :param)
  def make_query(raw_query)
    raw_query = raw_query.split(" ")
    Query.new(raw_query[0] + '?', raw_query[1].downcase)
  end

  def process_query(query)
    query.each do |command|
      formatted_query = make_query(command)
      send_query(formatted_query.function, formatted_query.param)
    end
    DinosaurCatalog.new(@dinosaurs)
  end

  def send_query(function, param)
    @dinosaurs = @dinosaurs.select do |dino|
      dino.send(function.to_sym, param)
    end
    @dinosaurs.uniq
  end

  def facts
    @dinosaurs.each do |dinosaur|
      puts ""
      puts instance_variable_collection(dinosaur)
      puts ""
    end
  end

  def instance_variable_collection(dinosaur)
    value = []
    dinosaur.instance_variables.each do |var|
      if dinosaur.instance_variable_get(var)
        value << var.to_s + ": " + dinosaur.instance_variable_get(var).to_s
      end
    end
    value
  end
end
