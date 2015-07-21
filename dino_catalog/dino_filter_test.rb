#!/usr/bin/env ruby
gem 'minitest', '>= 5.0.0'
require 'minitest/autorun'
require_relative 'dino_filter'
require_relative 'dinosaur'

class DinoFilterTest < Minitest::Test
  DINO1 = Dinosaur.new(name: "Dino", walking: "Quadruped", weight: "6000",
                       diet: "Carnivore", period: "Late Jurassic")
  DINO2 = Dinosaur.new(name: "Stomps", walking: "Quadruped", weight: "0.25",
                       period: "Early Jurassic")
  DINO3 = Dinosaur.new(name: "Grrromps", walking: "Biped", weight: "0.25",
                       diet: "gourmet", period: "Late Cretaceous")

  def test_search
    filter = DinoFilter.new(:name, "Stomps")
    dinos = filter.search([DINO1, DINO2, DINO3])
    assert_equal([DINO2], dinos)
  end

  def test_search_when_no_matches
    filter = DinoFilter.new(:name, "Joe")
    dinos = filter.search([DINO1, DINO2, DINO3])
    assert_equal([], dinos)
  end

  def test_search_when_multiple_matches
    filter = DinoFilter.new(:walking, "quadruped")
    dinos = filter.search([DINO1, DINO2, DINO3])
    assert_equal([DINO1, DINO2].sort, dinos.sort)
  end

  def test_search_when_desired_value_is_nil
    filter = DinoFilter.new(:diet, nil)
    dinos = filter.search([DINO1, DINO2, DINO3])
    assert_equal([DINO2], dinos)
  end

  def test_search_when_size
    filter = DinoFilter.new(:size, :big)
    dinos = filter.search([DINO1, DINO2, DINO3])
    assert_equal([DINO1], dinos)
  end

  def test_search_when_carnivore
    filter = DinoFilter.new(:carnivore, true)
    dinos = filter.search([DINO1, DINO2, DINO3])
    assert_equal([DINO1], dinos)
  end

  def test_search_when_period_includes_any_cretaceous
    filter = DinoFilter.new(:period, "cretaceous")
    dinos = filter.search([DINO1, DINO2, DINO3])
    assert_equal([DINO3], dinos)
  end

  def test_search_when_period_includes_late_jurassic
    filter = DinoFilter.new(:period, "late Jurassic")
    dinos = filter.search([DINO1, DINO2, DINO3])
    assert_equal([DINO1], dinos)
  end
end
