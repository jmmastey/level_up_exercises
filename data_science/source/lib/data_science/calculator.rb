module DataScience
  class Calculator
    def self.execute(importer_klass: Importer, parser_klass: Parser,
                     test_klass:     Test,     input_file:   nil)
      opts = { importer_klass: importer_klass, input_file: input_file }
      sample_data = parser_klass.load(opts)
      test_klass.new(sample_data).execute
    end
  end
end
