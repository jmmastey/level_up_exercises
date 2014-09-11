#!/usr/bin/ruby

require "csv"
require "./dino"
require "./dinoquery"

class DinoDex
  attr_writer :dinos
  def initialize(dinos = [])
    @dinos = dinos
  end

  def perform_query(commands)
    new_query.perform_commands!(commands).result
  end

  def new_query
    DinoQuery.new(@dinos.dup)
  end
end
