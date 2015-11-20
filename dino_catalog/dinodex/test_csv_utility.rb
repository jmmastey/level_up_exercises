require "./csv_utility"
require "test/unit"

class TestCsvUtility < Test::Unit::TestCase
  include CsvUtility

  def test_write_csv
    data_objects = []
    data_objects << {"a"=>"1","b"=>"2"}
    data_objects << {"a"=>"2","b"=>"4"}
    data_objects << {"a"=>"3","b"=>"6"}
    actual = CsvUtility.write_csv(data_objects)
    expected = "a,b\n1,2\n2,4\n3,6\n"
    assert_equal(expected, actual, "CSV String does not equal expected")
  end

  def test_valid_path
    actual = CsvUtility.valid_path?("")
    assert_equal(false, actual, "Empty String is an invalid file path")

    actual = CsvUtility.valid_path?("foo/bar.txt")
    assert_equal(false, actual, ".txt is an invalid file path")

    actual = CsvUtility.valid_path?(nil)
    assert_equal(false, actual, "nil is an invalid file path")

    actual = CsvUtility.valid_path?("fake/no_file_here.csv")
    assert_equal(false, actual, "a non-existent file should return false")

    actual = CsvUtility.valid_path?("../dinodex.csv")
    assert_equal(true, actual, "../dinodex.csv is a valid file path")
  end
end