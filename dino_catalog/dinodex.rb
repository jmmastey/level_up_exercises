#!/usr/bin/ruby

require 'csv'
require './dino'
require './dinoquery'

class DinoDex
  def initialize(dinos = [])
    @dinos = dinos
  end
  def load(dinos)
    @dinos = dinos
  end

  def query(key,op,arg)
    DinoQuery.new(@dinos.dup).and(key,op,arg)
  end

  def new_query
    DinoQuery.new(@dinos.dup)
  end
end
