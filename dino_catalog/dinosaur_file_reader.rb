class DinosaurFileReader
  attr_reader :dinosaurs
  attr_accessor :values
  def initialize(file_path)
    @path = file_path
    @dinosaurs = read_file
  end

  def read_file
    @values = CSV.read (@path )
    parse_raw_data
  end

  def parse_raw_data
    raise NotImplementedError, "this base class should never be initiated"
  end

  protected :initialize
end
