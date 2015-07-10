#!/usr/bin/env ruby
gem 'minitest', '>= 5.0.0'
require 'minitest/autorun'
require_relative 'dinodex_catalog'

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

  def test_search_by_hash
    catalog = DinoCatalog.new(dinosaurs: [DINO1, DINO2, DINO3])
    dinos = catalog.search_by_hash(size: :small, walking: "quadruped")
    assert_equal([DINO2], dinos)
  end
end

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

class DinosaurTest < Minitest::Test
  DINO1 = Dinosaur.new(name: "Dino", walking: "Quadruped", weight: "6000",
                       diet: "Carnivore", period: "Late Jurassic")
  DINO2 = Dinosaur.new(name: "Stomps", walking: "Quadruped", weight: "0.25",
                       period: "Early Jurassic")
  DINO3 = Dinosaur.new(name: "Grrromps", walking: "Biped", weight: "0.25",
                       diet: "gourmet", period: "Late Cretaceous")

  def test_initialize_ignores_bogus_attributes
    dino1 = Dinosaur.new(foo: "foo", name: "Dino")
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

# Proper testing would involve mocking out the data files.
class DinoFileTest < Minitest::Test
  def test_format_specific_reader_with_bogus_format
    dino_file = DinoFile.new("foo", :bogus)
    dino_file_method = dino_file.reader
    assert_nil(dino_file_method)
  end

  def test_csv_file_to_hashes
    dino_file = DinoFile.new("original_format_test_data.csv", :original)
    dino_hash = dino_file.csv_file_to_hashes
    expected = [
      { name: "Bary", period: "Early Cre", continent: "Eur", diet: "Piscivore",
        weight_in_lbs: "6000", walking: "Biped", description: "Rare diet." },
    ]
    assert_equal(expected, dino_hash)
  end

  def test_original_format_hash_to_dinosaur
    dino_file = DinoFile.new("foo", :original)
    dino_hash = { name: "Di", period: "Sc", continent: "x", diet: "y",
                  weight_in_lbs: "20", walking: "quad", description: "boo!" }
    dinosaur = dino_file.original_format_hash_to_dinosaur(dino_hash)
    expected = Dinosaur.new(name: "Di", period: "Sc", continent: "x", diet: "y",
                            weight: "20", walking: "quad", description: "boo!")
    assert_equal(expected, dinosaur)
  end

  def test_p_b_africa_format_hash_to_dinosaur
    dino_file = DinoFile.new("foo", :p_b_africa)
    dino_hash = { genus: "Dino", period: "Sec", carnivore: "Yes",
                  weight: "2000", walking: "quad" }
    dinosaur = dino_file.p_b_africa_format_hash_to_dinosaur(dino_hash)
    expected = Dinosaur.new(continent: "Africa", name: "Dino", period: "Sec",
                            diet: "Carnivore", weight: "2000", walking: "quad")
    assert_equal(expected, dinosaur)
  end
end
