require_relative '../../spec_helper.rb'

module DataScience
  klass = Parser
  describe klass do
    OPTIONS = {
      importer_klass: JSONImporter,
      input_file: "#{PROJECT_ROOT}/data/conversion_sample.json"
    }

    me = klass.load(OPTIONS)

    context 'when importing' do
      it 'delegates reading of input' do
        expect_me = expect { klass.read(OPTIONS) }
        expect_me.not_to raise_error
      end
    end

    context 'when parsing' do
      it 'returns all valid data' do
        me = klass.load(OPTIONS)
        expect(me.size).to eq(2892)
      end
    end
  end
end
