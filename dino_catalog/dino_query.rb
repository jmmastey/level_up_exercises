require_relative './parse.rb'
require_relative './dinosaur.rb'

class DinoQuery
  attr_accessor :dinos

  def initialize
    @dinos = Parser.parse
  end
end
