require_relative '../../spec_helper.rb'

module DataScience
  klass = JSONImporter
  describe klass do
    import_path = "#{PROJECT_ROOT}/data/conversion_sample.json"

    context 'when importing' do
      it 'loads the input data' do
        me = klass.load(import_path)
        expect(me.size).to eq(2892)
      end
    end
  end
end
