#!/usr/bin/env ruby
gem 'minitest', '>= 5.0.0'
require 'minitest/autorun'
require_relative 'dinosaur'

class DinosaurTest < Minitest::Test
  DINO1 = Dinosaur.new(name: "Dino", walking: "Quadruped", weight: "6000",
                       diet: "Carnivore", period: "Late Jurassic")
  DINO2 = Dinosaur.new(name: "Stomps", walking: "Quadruped", weight: "0.25",
                       period: "Early Jurassic")
  DINO3 = Dinosaur.new(name: "Grrromps", walking: "Biped", weight: "0.25",
                       diet: "gourmet", period: "Late Cretaceous")

  def test_initialize_ignores_bogus_attributes
    dino1 = Dinosaur.new(bogus: "bogus", name: "Dino")
    dino2 = Dinosaur.new(name: "Dino")
    assert_equal(dino1.to_s, dino2.to_s)
  end

  def test_to_s_leaves_out_empty_attributes
    dino = Dinosaur.new(name: "Dino", period: "Flintstonian")
    assert_equal("Name: Dino, Period: Flintstonian", dino.to_s)
  end

  def test_to_s_correctly_formats_all_attributes
    dino = Dinosaur.new(name: "Dino", period: "Early Flintstonian",
                        continent: "ours", diet: "table scraps", weight: "2000",
                        walking: "quadruped", description: "Lovably energetic!")
    expected = "Name: Dino, Period: Early Flintstonian, Continent: ours, "
    expected << "Diet: table scraps, Weight: 2000, Walking: quadruped, "
    expected << "Description: Lovably energetic!"
    assert_equal(expected, dino.to_s)
  end

  def test_searchable_attrs
    dino = Dinosaur.new(name: "Dino")
    attrs = dino.searchable_attrs
    expected = %w(carnivore size name period continent diet weight walking
                  description)
    assert_equal(expected.sort, attrs.sort)
  end

  def test_equal_equal
    dino_a = Dinosaur.new(name: "Stomps", walking: "Quadruped", weight: "0.25")
    dino_b = Dinosaur.new(name: "Stomps", walking: "Quadruped", weight: "0.25")
    assert_equal(dino_a, dino_b)
  end

  def test_less_than_when_different_name
    dino_a = Dinosaur.new(name: "Stomps", walking: "Quadruped", weight: "0.25")
    dino_b = Dinosaur.new(name: "Tromps", walking: "Quadruped", weight: "0.25")
    assert_equal(true, dino_a < dino_b)
  end

  def test_greater_than_when_different_name
    dino_a = Dinosaur.new(name: "Stomps", walking: "Quadruped", weight: "0.25")
    dino_b = Dinosaur.new(name: "Tromps", walking: "Quadruped", weight: "0.25")
    assert_equal(false, dino_a > dino_b)
  end

  def test_less_than_equal_greater_than_when_different_name
    dino_a = Dinosaur.new(name: "Stomps", walking: "Quadruped", weight: "0.25")
    dino_b = Dinosaur.new(name: "Tromps", walking: "Quadruped", weight: "0.25")
    assert_equal(-1, dino_a <=> dino_b)
  end

  def test_less_than_equal_greater_than_when_all_same
    dino_a = Dinosaur.new(name: "Stomps", walking: "Quadruped", weight: "0.25")
    dino_b = Dinosaur.new(name: "Stomps", walking: "Quadruped", weight: "0.25")
    assert_equal(0, dino_a <=> dino_b)
  end
end
