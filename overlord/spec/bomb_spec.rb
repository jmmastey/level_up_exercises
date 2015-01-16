require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Overlord::Bomb do
  # let(:overlord) do
  #   Overlord.new
  # end

  describe '#new' do
    it 'returns an inactive bomb' do
      expect(Overlord::Bomb.new).not_to be_active
    end

    it 'initializes itself to supplied parameters' do
      expect(Overlord::Bomb.new(:state => "activated")).to be_active
    end
  end

  describe '#process_code' do
    context 'when the bomb is inactive' do
      context 'when it receives a valid activation code' do
        it 'activates the bomb' do
          bomb = Overlord::Bomb.new
          bomb.process_code('1234')

          expect(bomb).to be_active
        end
      end
    end

    context 'when the bomb is active' do
      context 'when it receives a valid deactivation code' do
        it 'activates the bomb' do
          bomb = Overlord::Bomb.new
          bomb.process_code('1234')
          bomb.process_code('0000')


          expect(bomb).not_to be_active
        end
      end
    end
  end

  describe '#initialize_session' do
    it 'writes its state to the supplied hash' do
      bomb = Overlord::Bomb.new
      bomb.process_code('1234')
      session = bomb.initialize_session

      expect(session[:state]).to eq('activated')
    end
  end
end
