module DataScience
  class Importer
    def self.load(input_file)
      read(input_file)
    end

    def self.read(input_file)
      IO.read(input_file)
    end
  end
end
