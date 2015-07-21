#!/usr/bin/env ruby
gem 'minitest', '>= 5.0.0'
require 'minitest/autorun'
require_relative 'dino_file'

# Proper testing would involve mocking out the data files.
class DinoFileTest < Minitest::Test
  def test_initialize_with_bogus_format
    assert_raises(DinoBadFormat) do
      DinoFile.new(path: "bogus_format_test_data.csv")
    end
  end

  def test_initialize_with_empty_file
    assert_raises(EOFError) do
      DinoFile.new(path: "empty_test_data.csv")
    end
  end

  def test_initialize_with_nonexistent_file
    assert_raises(Errno::ENOENT) do
      DinoFile.new(path: "not_here.csv")
    end
  end

  def test_csv_file_to_h_with_original_format
    dino_file = DinoFile.new(path: "original_format_test_data.csv")
    dinos = dino_file.csv_file_to_h
    expected = [
      { name: "Bary", period: "Early Cre", continent: "Eur", diet: "Piscivore",
        weight_in_lbs: "6000", walking: "Biped", description: "Rare diet." },
    ]
    assert_equal(expected, dinos)
  end

  def test_csv_file_to_h_with_p_b_africa_format
    dino_file = DinoFile.new(path: "p_b_africa_format_test_data.csv")
    dinos = dino_file.csv_file_to_h
    expected = [
      { genus: "Bary", period: "Early Cre", carnivore: "Yes", weight: "6000",
        walking: "Biped" },
    ]
    assert_equal(expected, dinos)
  end

  def test_original_format_to_dinosaur
    dino_file = DinoFile.new
    dino = { name: "Di", period: "Sc", continent: "x", diet: "y",
             weight_in_lbs: "20", walking: "quad", description: "boo!" }
    dinosaur = dino_file.original_format_to_dinosaur(dino)
    expected = Dinosaur.new(name: "Di", period: "Sc", continent: "x", diet: "y",
                            weight: "20", walking: "quad", description: "boo!")
    assert_equal(expected, dinosaur)
  end

  def test_p_b_africa_format_to_dinosaur
    dino_file = DinoFile.new
    dino = { genus: "Dino", period: "Sec", carnivore: "Yes", weight: "2000",
             walking: "quad" }
    dinosaur = dino_file.p_b_africa_format_to_dinosaur(dino)
    expected = Dinosaur.new(continent: "Africa", name: "Dino", period: "Sec",
                            diet: "Carnivore", weight: "2000", walking: "quad")
    assert_equal(expected, dinosaur)
  end

  def test_read_with_original_format
    dino_file = DinoFile.new(path: "original_format_test_data.csv")
    expected = [
      Dinosaur.new(name: "Bary", period: "Early Cre", continent: "Eur",
                   diet: "Piscivore", weight: "6000", walking: "Biped",
                   description: "Rare diet."),
    ]
    assert_equal(expected, dino_file.read)
  end

  def test_read_with_p_b_africa_format
    dino_file = DinoFile.new(path: "p_b_africa_format_test_data.csv")
    expected = [
      Dinosaur.new(name: "Bary", period: "Early Cre", continent: "Africa",
                   diet: "Carnivore", weight: "6000", walking: "Biped"),
    ]
    assert_equal(expected, dino_file.read)
  end
end
