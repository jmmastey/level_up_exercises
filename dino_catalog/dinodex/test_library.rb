require "./library"
require "test/unit"

class TestLibrary < Test::Unit::TestCase
  include Library

  def test_get_all_files_loaded
    assert_not_nil(Library.get_all_files_loaded)
    assert_equal(true, Library.get_all_files_loaded.length > 0)
  end

  def test_create_hash_from_mapping
    column_mapping = { "name" => "genus", "weight_in_lbs" => "weight" }

    hash = { "genus" => "foo", "weight" => "10", "bar" => "42" }
    actual_hash = Library.create_hash_from_mapping(hash, column_mapping)
    expected_hash = { "name" => "foo", "weight_in_lbs" => "10" }
    assert_equal(expected_hash, actual_hash, "Expected hash is not equal")

    hash = { "name" => "foo", "weight_in_lbs" => "10", "bar" => "42" }
    actual_hash = Library.create_hash_from_mapping(hash, column_mapping)
    expected_hash = { "name" => "foo", "weight_in_lbs" => "10" }
    assert_equal(expected_hash, actual_hash, "Expected hash is not equal")
  end

  def test_parse_search_values
    key = "key"
    string = ""
    actual = Library.parse_search_values(key, string)
    expected = ["key", "==", ""]
    assert_equal(expected, actual, "Actual is not equal to expected")

    string = "foo"
    actual = Library.parse_search_values(key, string)
    expected = ["key", "==", "foo"]
    assert_equal(expected, actual, "Actual is not equal to expected")

    string = ">2"
    actual = Library.parse_search_values(key, string)
    expected = ["key", ">", "2"]
    assert_equal(expected, actual, "Actual is not equal to expected")

    string = "=foo"
    actual = Library.parse_search_values(key, string)
    expected = ["key", "==", "foo"]
    assert_equal(expected, actual, "Actual is not equal to expected")

    string = "<=2"
    actual = Library.parse_search_values(key, string)
    expected = ["key", "<=", "2"]
    assert_equal(expected, actual, "Actual is not equal to expected")

    string = "=~bar"
    actual = Library.parse_search_values(key, string)
    expected = ["key", "=~", "bar"]
    assert_equal(expected, actual, "Actual is not equal to expected")
  end
end
