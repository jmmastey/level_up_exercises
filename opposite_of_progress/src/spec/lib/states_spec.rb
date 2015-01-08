require 'rails_helper'
RSpec.describe States do
  context '.abbr_to_state' do
    it 'return the abbreviation if valid abbreviation is given as string' do
      expect(States.abbr_to_state('IL')).to eq("Illinois")
    end

    it 'return the state name if valid abbreviation is given as symbol' do
      expect(States.abbr_to_state(:IL)).to eq("Illinois")
    end

    it 'returns nil if invalid abbreviation is given' do
      expect(States.abbr_to_state(:ZZ)).to be_nil
    end
  end

  context '.state_to_abbr' do
    context 'when requested as string' do
      it 'return the abbreviation if valid state is given' do
        expect(States.state_to_abbr('Illinois')).to eq("IL")
      end

      it 'returns nil if invalid state is given' do
        expect(States.state_to_abbr("Baja California")).to be_nil
      end
    end

    context 'when requested as symbol' do
      it 'return the abbreviation if valid state is given' do
        expect(States.state_to_abbr('Illinois', true)).to eq(:IL)
      end

      it 'returns nil if invalid state is given' do
        expect(States.state_to_abbr("Baja California", true)).to be_nil
      end
    end
  end
end
