require 'pry'
require './bomb.rb'

describe Bomb do
  def random_code(num = 4)
    loop do
      code = ''
      num.times { code += rand(9).to_s }
      return code unless @security_codes.include? code
    end
  end

  def activate_bomb
    subject.activate(@security_codes[:activate])
  end

  def deactivate_bomb
    subject.deactivate(@security_codes[:deactivate])
  end

  def explode_bomb
    activate_bomb
    3.times { subject.deactivate(random_code) }
  end

  before(:all) do
    @security_codes = {
      activate: '1234', # default
      deactivate: '0000', #default
    }
  end

  shared_examples 'mutable bomb' do

    subject { Bomb.new(@security_codes[:activate], @security_codes[:deactivate]) }

    context 'is initialized' do
      it 'state should be in "inactive" state upon initialization' do
        expect(subject.status).to eq('inactive')
      end
    end

    context 'in "inactive" state' do
      before(:example) do
        deactivate_bomb
      end

      it 'should be in "active" state when we enter the correct activation code' do
        activate_bomb
        expect(subject.status).to eq('active')
      end

      it 'should remain in "inactive" state when we enter the correct deactivation code' do
        deactivate_bomb
        expect(subject.status).to eq('inactive')
      end
    end

    context 'in "active" state' do
      before(:example) do
        activate_bomb
      end

      it 'should remain in "active" state when an incorrect deactivation code is entered once' do
        subject.deactivate(random_code)
        expect(subject.status).to eq('active')
      end

      it 'should remain in "active" state when an incorrect deactivation code is entered twice consecutively' do
        2.times { subject.deactivate(random_code) }
        expect(subject.status).to eq('active')
      end

      it 'should be in "exploded" state when an incorrect deactivation code was entered 3 times consecutively' do
        explode_bomb
        expect(subject.status).to eq('exploded')
      end
    end

    context 'in "exploded" state' do
      before(:example) do
        explode_bomb
      end

      it 'should remain in "exploded" state when we enter the correct activation code' do
        activate_bomb
        expect(subject.status).to eq('exploded')
      end

      it 'should remain in "exploded" state when we enter the correct deactivation code' do
        deactivate_bomb
        expect(subject.status).to eq('exploded')
      end

      it 'should remain in "exploded" state when we enter the incorrect activation code' do
        subject.activate(random_code)
        expect(subject.status).to eq('exploded')
      end

      it 'should remain in "exploded" state when we enter the correct deactivation code' do
        subject.deactivate(random_code)
        expect(subject.status).to eq('exploded')
      end
    end
  end

  context 'using default security codes' do
    it_behaves_like 'mutable bomb' do
    end
  end

  context 'using custom security codes' do
    it_behaves_like 'mutable bomb' do
      before(:context) do
        @security_codes = {
          activate: random_code,
          deactivate: random_code,
        }
      end
    end
  end
end
