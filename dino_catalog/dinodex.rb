#!/usr/bin/ruby

require 'csv'
require './dino'
require './dinoquery'

class DinoDex
  @dinos = []
  def load(dinos)
    @dinos = dinos
  end

  def query(key,op,arg)
    dino_query = DinoQuery.new(@dinos.dup)
    return dino_query.and(key,op,arg)
  end

end
