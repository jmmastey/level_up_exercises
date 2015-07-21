#!/usr/bin/env ruby
gem 'minitest', '>= 5.0.0'
require 'minitest/autorun'
require_relative 'dinodex_catalog'
require_relative 'dinosaur'

class DinoCatalogTest < Minitest::Test
  DINO1 = Dinosaur.new(name: "Dino", walking: "Quadruped", weight: "6000",
                       diet: "Carnivore", period: "Late Jurassic")
  DINO2 = Dinosaur.new(name: "Stomps", walking: "Quadruped", weight: "0.25",
                       period: "Early Jurassic")
  DINO3 = Dinosaur.new(name: "Grrromps", walking: "Biped", weight: "0.25",
                       diet: "gourmet", period: "Late Cretaceous")

  def test_search_by_attr
    catalog = DinoCatalog.new(dinosaurs: [DINO1, DINO2, DINO3])
    dinos = catalog.search_by_attr(:name, "Stomps")
    assert_equal([DINO2], dinos)
  end

  def test_search_by_multiple_attrs
    catalog = DinoCatalog.new(dinosaurs: [DINO1, DINO2, DINO3])
    dinos = catalog.search_by_multiple_attrs(size: :small, walking: "quadruped")
    assert_equal([DINO2], dinos)
  end
end
