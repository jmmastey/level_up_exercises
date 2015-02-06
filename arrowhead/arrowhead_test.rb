require 'minitest/autorun'
begin
  require_relative 'arrowhead'
rescue LoadError => e
  puts "\n\n#{e.backtrace.first} #{e.message}"
  puts DATA.read
  exit 1
end

class ArrowheadTest < MiniTest::Unit::TestCase

  def test_classify_northern_plains_bifurcated
    out, err = capture_io do
      Arrowhead.classify(:northern_plains, :bifurcated)
    end
    assert_equal "You have a(n) 'Oxbow' arrowhead. Probably priceless.\n", out
  end

end

__END__

*****************************************************
 You got an error
*****************************************************
