require 'minitest/autorun'
begin
  require_relative 'dino_catalog'
  require_relative 'dino'
rescue LoadError => e
  puts "\n\n#{e.backtrace.first} #{e.message}"
  # puts DATA.read
  exit 1
end

class DinoCatalogTest < Minitest::Test
  def test_load_catalog_dinodex
    dinodex_catalog = DinoCatalog.new("dinodex.csv")
    assert_equal 10, dinodex_catalog.dino_count, "We loaded dinodex.csv, we need to get 10 Dinos"
  end

  def test_load_catalog_african
    # skip
    african_catalog = DinoCatalog.new("african_dinosaur_export.csv")
    assert_equal 7, african_catalog.dino_count, "We loaded african_dinosaur_export.csv, we need to get 11 Dinos"
  end

  def test_dino_init
    dino_csv = CSV.open("dinodex.csv")
    headers = dino_csv.readline
    row = dino_csv.readlines[0]
    new_dino = Dino.new(attributes:headers,details:row)

    csv_headers = headers.each{|a| a.downcase!}.to_s.gsub(/[\]"\[@:]/,'')
    object_headers = new_dino.instance_variables.to_s.gsub(/[\]\[@:]/,'')

    assert_equal csv_headers, object_headers, "Dino object attributes are not set!"
  end

end
