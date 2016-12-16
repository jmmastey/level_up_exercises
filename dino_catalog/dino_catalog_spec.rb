require 'rspec'
require_relative 'dino_catalog'

describe DinoCatalog do
  before(:each) do
    @dino_log = DinoCatalog.new
    @dino_log.parse('dinodex.csv')
    @dino_log.parse('african_dinosaur_export.csv')
    @dino = @dino_log.dino_dex.first
  end

  it "should parse a CSV file and create an array of Dinos" do
    expect(@dino_log.dino_dex.first).to be_a Dino
  end

  it "should search by Dino name" do
    dino_results = @dino_log.name_search(@dino.name)
    expect(dino_results).to include(a_kind_of(Dino))
    expect(dino_results.count).to be(1)
  end

  it "should search by Dino walking style" do
    dino_results = @dino_log.walking_search("Biped")
    expect(dino_results).to include(a_kind_of(Dino))
    expect(dino_results.count).to be(11)
  end

  it "should return Dinos that are carnivores " do
    dino_results = @dino_log.carnivores
    expect(dino_results).to include(a_kind_of(Dino))
    expect(dino_results.count).to be(12)
  end

  it "should search by Dino period" do
    dino_results = @dino_log.period_search("Cretaceous")
    expect(dino_results).to include(a_kind_of(Dino))
    expect(dino_results.count).to be(9)
  end

  it "should search for big dinos" do
    dino_results = @dino_log.big_dinos
    expect(dino_results).to include(a_kind_of(Dino))
    expect(dino_results.count).to be(8)
  end

  it "should search for small dinos" do
    dino_results = @dino_log.small_dinos
    expect(dino_results).to include(a_kind_of(Dino))
    expect(dino_results.count).to be(5)
  end

  it "should search for multiple names" do
    dino_results = @dino_log.name_search("Albertosaurus", "Baryonyx")
    expect(dino_results.count).to be(2)
  end

  it "should search for multiple walking types" do
    dino_results = @dino_log.walking_search("Biped", "Quadruped")
    expect(dino_results.count).to be(17)
  end

  it "should search for multiple terms" do
    dino_results = @dino_log.dino_search(period_search: "Permian",
                                         walking_search: "Quadruped")
    expect(dino_results.count).to be(6)
  end
end
