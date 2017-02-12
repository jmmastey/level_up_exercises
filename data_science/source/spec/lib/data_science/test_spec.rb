require_relative '../../spec_helper.rb'

module DataScience
  klass = Test
  describe klass do
    import_data = { foo: :bar }

    me = klass.new(import_data).execute

    context 'when instantiating' do
      context 'and populating sample data' do
        it 'exposes `data` hash attr_reader' do
          expect(me.data).not_to be_nil
          expect(me.data).not_to be_empty
        end
        it 'populates `data` hash with accurate values' do
          expect(me.data).to eq(import_data)
        end
      end
    end

    context 'when executing' do
      context 'and calculating results' do
        it 'exposes `results` hash attr_reader' do
          expect(me.results).not_to be_nil
          expect(me.results).not_to be_empty
        end
        it 'exposes correct fields in `results` hash' do
          expect(me.results[:status]).not_to be_nil
        end
        it 'populates `results` hash with accurate values' do
          expect(me.results[:status]).to eq(:OK)
        end
      end
    end
  end
end
