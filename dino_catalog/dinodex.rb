require_relative 'dinodex_reader'

class Dinodex
  attr_accessor :dinosaurs

  def load_dinosaurs_file(csv_path, type = 'none')
    dinodex_reader = DinodexReader.new(csv_path, type)
    @dinosaurs = dinodex_reader.fetch
    binding.pry
  end

  def search(params)
  end
end

dinodex = Dinodex.new
dinodex.load_dinosaurs_file("dinodex.csv")
