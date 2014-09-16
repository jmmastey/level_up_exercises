require_relative '../../spec_helper.rb'

module DataScience
  module Specs
    klass = SplitTest
    calculator_klass = SplitTestCalculator
    describe klass do
      OPTIONS = {
        importer_klass: JSONImporter,
        input_file: "#{PROJECT_ROOT}/data/conversion_sample.json"
      }

      # FIXME: Directly test against SplitTest or through SplitTestParser?
      me = calculator_klass.execute(OPTIONS)

      context 'when instantiating' do
        context 'and populating sample data' do
          it 'exposes `data` hash attr_reader' do
            expect(me.data).not_to be_nil
            expect(me.data).not_to be_empty
          end
          it 'exposes correct fields in `data` hash' do
            me.data.each do |_, data_hash|
              expect(data_hash).not_to be_empty
              expect(data_hash[:hits]).not_to be_nil
              expect(data_hash[:misses]).not_to be_nil
              expect(data_hash[:total]).not_to be_nil
            end
          end
          it 'populates `data` hash with accurate values' do
            expected = {
              A: { hits: 47, misses: 1302, total: 1349 },
              B: { hits: 79, misses: 1464, total: 1543 }
            }
            expect(me.data).to eq(expected)
          end
        end
      end

      context 'when executing' do
        context 'and calculating results' do
          it 'exposes `results` hash attr_reader' do
            expect(me.results).not_to be_nil
          end
          it 'exposes correct fields in `results` hash' do
            expect(me.results).not_to be_empty
            expect(me.results[:p_value]).not_to be_nil
            expect(me.results[:score]).not_to be_nil
            expect(me.results[:groups]).not_to be_empty
            me.results[:groups].each do |_, results_hash|
              expect(results_hash).not_to be_empty
              expect(results_hash[:conversion]).not_to be_nil
              expect(results_hash[:confidence_interval]).not_to be_nil
            end
          end
          it 'populates `results` hash with accurate values' do
            expected = {
              status: :OK,
              confidence_level: 0.95,
              p_value: 0.03156402546059378,
              score: 4.622021107958111,
              groups: {
                A: {
                  conversion: 0.034840622683469234,
                  confidence_interval: [
                    0.025055087455844,
                    0.04462615791109446
                  ]
                },
                B: {
                  conversion: 0.05119896305897602,
                  confidence_interval: [
                    0.04020173369400816,
                    0.06219619242394388
                  ]
                }
              }
            }
            expect(me.results).to eq(expected)
          end
        end
      end
    end
  end
end
