require 'csv'
require_relative "dinosaur"

class Dinosaurs
  attr_reader :dinosaurs

  def initialize(files = Dir["../dino_fact_csvs/*"])
    @dinosaurs = build_dinosaurs(files)
  end

  def build_dinosaurs(file_paths)
    file_paths.each_with_object([]) do |file_path, dinosaurs|
      CSV.foreach(file_path, 
                  converters: :numeric, 
                  headers: true,
                  :header_converters => lambda {|h| h.downcase}
                  ) do |row|
        dinosaurs << Dinosaur.from_csv_row(row)
      end
    end
  end
end


collection = Dinosaurs.new
p collection