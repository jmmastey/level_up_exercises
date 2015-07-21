require './dinodex.rb'
require './dino.rb'
require './dino_parse.rb'

class DinoTest
  attr_accessor :dinodex

  def initialize
    file1 = 'dinodex.csv'
    file2 = 'african_dinosaur_export.csv'

    dinos1 = DinoParse.new(file1).dinos
    dinos2 = DinoParse.new(file2).dinos

    @dinodex = Dinodex.new(dinos1 + dinos2)
  end

  def horizontal_rule
    puts "_" * 20
  end

  def execute(case_string, query_result)
    puts case_string
    horizontal_rule
    query_result.index
    puts
  end

  def test1
    case_str = "Grab all dinosaurs that were bipeds"

    query = dinodex.equal('walking', 'biped')
    execute(case_str, query)
  end

  def test2
    case_str = "Grab all the dinosaurs that were carnivores"
    case_str << " (fish and insects count)"

    query = dinodex.not_equal('diet', 'herbivore')
    execute(case_str, query)
  end

  def test3
    case_str =  "Grab dinosaurs for specific periods (no need to"
    case_str << " differentiate between early and late cretaceous, btw.)"

    query = dinodex.like('period', 'cretaceous')
    execute(case_str, query)
  end

  def test4
    case_str = "Grab only big (> 2 tons) or small dinosaurs."

    query = dinodex.greater_than('weight', '4000')
    execute(case_str, query)
  end

  def test5
    case_str = "Just to be sure, I'd love to be able to combine criteria"
    case_str << " at will, even better if I can chain filter calls together"

    query = dinodex.like('name', 'D...o')
            .like('period', 'early')
            .like('continent', 'america')
    execute(case_str, query)
  end

  def test6
    case_str = "Another example of chaining."

    query = dinodex.like('name', 'saurus')
            .greater_or_equal('weight', '10000')
    execute(case_str, query)
  end

  def test7
    case_str = "I would love to have a way to do (and chain) generic"
    case_str << " search by parameters. I can pass in a hash, and I'd like to"
    case_str << " get the proper list of dinos back out."

    query = dinodex.search('diet' => 'carnivore', 'continent' => 'europe')
    execute(case_str, query)
  end

  def test8
    case_str = "CSV isn't may favorite format in the world. Can"
    case_str << " you implement a JSON export feature?"

    puts case_str
    puts dinodex.equal('continent', 'Africa').to_json
  end

  def test_all
    (1..8).each do |test_number|
      send("test#{test_number}")
    end
  end
end

DinoTest.new.test_all
# DONE
