module DataScience
  class Parser
    def self.load(importer_klass: Importer, input_file: nil)
      opts = { importer_klass: importer_klass, input_file: input_file }
      raw_data = read(opts)
      parse(raw_data)
    end

    def self.read(importer_klass: Importer, input_file: nil)
      importer_klass.load(input_file)
    end

    def self.parse(input_data)
      input_data
    end
  end
end
