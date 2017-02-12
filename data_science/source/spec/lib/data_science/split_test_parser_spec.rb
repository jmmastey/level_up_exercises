require_relative '../../spec_helper.rb'

module DataScience
  klass = SplitTestParser
  describe klass do
    OPTIONS = {
      importer_klass: JSONImporter,
      input_file: "#{PROJECT_ROOT}/data/conversion_sample.json"
    }

    me = klass.load(OPTIONS)

    context 'when parsing' do
      it 'returns all valid data' do
        expected = {
          A: { hits: 47, misses: 1302, total: 1349 },
          B: { hits: 79, misses: 1464, total: 1543 }
        }
        expect(me).to eq(expected)
      end
    end
  end
end
