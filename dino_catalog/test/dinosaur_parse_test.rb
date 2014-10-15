require 'minitest/autorun'
require_relative '../dinosaur_parser.rb'

class DinosaurParserTest < MiniTest::Unit::TestCase
  def test_process_header_should_handle_valid_header
    assert_equal('weight_in_lbs', DinosaurParser.process_header("WEIGHT IN LBS"))
  end

  def test_process_header_should_handle_valid_alias
    assert_equal('weight_in_lbs', DinosaurParser.process_header("weight"))
  end

  def test_process_header_should_handle_invalid_header
    assert_equal(nil, DinosaurParser.process_header("capacity"))
  end

  def test_valid_file_should_fail_for_non_existing_file
    assert_equal(false, DinosaurParser.valid_file?("dinodex.csv"))
  end

  def test_valid_file_should_pass_for_existing_csv_file
    assert_equal(true, DinosaurParser.valid_file?("../dinodex.csv"))
  end

  def test_valid_file_should_pass_for_existing_non_csv_file
    assert_equal(false, DinosaurParser.valid_file?("dinodex.jpg"))
  end

  def test_param_hash
    DinosaurParser.create_default_params
    assert_equal(true, DinosaurParser.param_hash.keys.include?(:weight_in_lbs))
  end
end
