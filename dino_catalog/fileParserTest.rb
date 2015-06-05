require_relative 'dinodex.rb'


class TestMeme < MiniTest::Unit::TestCase

  def test_parse_csv_file
    dinos = FileParser.parse_csv_file("dinodex.csv")
    assert dinos.size == 10
    assert dinos[0].name == "Albertosaurus"
    assert dinos[-1].name == "Yangchuanosaurus"
  end

  def test_parse_tpb_file
    dinos = FileParser.parse_csv_file("african_dinosaur_export.csv")
    assert dinos.size == 7
    assert dinos[0].name = "Abrictosaurus"
    assert dinos[-1].name == "Melanorosaurus"
  end


end
