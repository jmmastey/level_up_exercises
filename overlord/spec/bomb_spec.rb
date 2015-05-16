require './bomb.rb'

describe Bomb do
  def random_number
    loop do
      random_number = rand(0..999_999_999)
      return random_number unless defined? @security_codes
      return random_number unless @security_codes.any? do |_key, value|
        value == random_number
      end
    end
  end

  shared_examples 'mutable bomb' do
    subject(:bomb) { Bomb.new(@security_codes[:activate], @security_codes[:deactivate]) }

    it 'state should be in "inactive" state' do
      expect(bomb.status).to eq('inactive')
    end

    it 'should be in "active" state when we enter the correct activation code' do
      bomb.activate(@security_codes[:activate])
      expect(bomb.status).to eq('active')
    end

    it 'should be in "inactive" state when we enter the correct deactivation code' do
      bomb.activate(@security_codes[:activate])
      bomb.deactivate(@security_codes[:deactivate])
      expect(bomb.status).to eq('inactive')
    end

    it 'should be in "exploded" state when in "active" state and an incorrect deactivation code was entered 3 times consecutively' do
      bomb.activate(@security_codes[:custom_activate])
      3.times { bomb.deactivate(random_number) }
      expect(bomb.status).to eq('exploded')
    end
  end

  before(:all) do
    @security_codes = {
      activate: 1234, # default
      deactivate: 0000, # default
    }
  end

  context 'using default security codes' do
    it_behaves_like 'mutable bomb' do
    end
  end

  context 'using custom security codes' do
    it_behaves_like 'mutable bomb' do
      before(:all) do
        @security_codes = {
          activate: random_number,
          deactivate: random_number,
        }
      end
    end
  end
end
