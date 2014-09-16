require_relative '../../spec_helper.rb'

module DataScience
  klass = Importer
  describe klass do
    import_path = "#{PROJECT_ROOT}/data/conversion_sample.json"

    context 'when importing' do
      it 'finds the input file' do
        expect_me = expect { klass.read(import_path) }
        expect_me.not_to raise_error
      end

      it 'loads the input data' do
        me = klass.load(import_path)
        expect(me).not_to be_empty
      end
    end
  end
end
