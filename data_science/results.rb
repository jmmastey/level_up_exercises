class Results
  attr_reader :filename, :cohorts

  def initialize
    @cohorts = []
  end

  def read(filename)
    @filename = filename
  end
end

