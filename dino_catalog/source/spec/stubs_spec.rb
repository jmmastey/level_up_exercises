# rubocop:disable all
load "#{File.dirname(__FILE__)}/../main.rb"

require_relative 'spec_helper.rb'

describe DinoDex::Catalog do
  c = DinoDex::Catalog.new(DinoDex::Dinosaur)
  c.import('data/african_dinosaur_export.csv', 'data/dinodex.csv')

  context 'importing' do
    it 'will have contain X entries' do
      expected = 16
      expect(c.entries.size).to eq(expected)
    end
    it 'will use `value` from yml configuration' do
      x = c.where(continent: :africa)
      expected = %i(abrictosaurus afrovenator carcharodontosaurus giraffatitan melanorosaurus paralititan suchomimus)
      expect(x.collect(&:genus).sort.sort).to eq(expected)
    end
  end
  context 'querying' do
    context 'for equality' do
      it 'will match' do
        x = c.where(diet: :carnivore).and(locomotion_type: :biped)
        expected = %i(afrovenator albertosaurus carcharodontosaurus deinonychus giganotosaurus megalosaurus suchomimus yangchuanosaurus)
        expect(x.collect(&:genus).sort.sort).to eq(expected)
      end
    end
    context 'for substring inclusion' do
      it 'will match' do
        x = c.where(period: :cretaceous)
        expected = %i(albertonykus albertosaurus baryonyx deinonychus giganotosaurus paralititan quetzalcoatlus suchomimus)
        expect(x.collect(&:genus).sort.sort).to eq(expected)
      end
    end
    context 'for comparison' do
      context 'with symbols' do
        context 'and hashes' do
          it 'will match' do
            x = c.where(diet: :carnivore).and(locomotion_type: :biped)
            x = x.where(weight: { :>= => 5000 })
            expected = %i(giganotosaurus suchomimus yangchuanosaurus)
            expect(x.collect(&:genus).sort).to eq(expected)
          end
        end
        context 'and arrays' do
          it 'will match' do
            x = c.where(diet: :carnivore).and(locomotion_type: :biped)
            x = x.where(weight: [:>=, 5000])
            expected = %i(giganotosaurus suchomimus yangchuanosaurus)
            expect(x.collect(&:genus).sort).to eq(expected)
          end
        end
      end
      context 'with strings' do
        context 'and hashes' do
          it 'will match' do
            x = c.where(diet: :carnivore).and(locomotion_type: :biped)
            x = x.where(weight: { '<' => 5000 })
            expected = %i(albertosaurus carcharodontosaurus deinonychus megalosaurus)
            expect(x.collect(&:genus).sort).to eq(expected)
          end
        end
        context 'and arrays' do
          it 'will match' do
            x = c.where(diet: :carnivore).and(locomotion_type: :biped)
            x = x.where(weight: ['<', 5000])
            expected = %i(albertosaurus carcharodontosaurus deinonychus megalosaurus)
            expect(x.collect(&:genus).sort).to eq(expected)
          end
        end
      end
    end
  end
end
# rubocop:enable all
