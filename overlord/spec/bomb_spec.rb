require_relative '../models/bomb'

describe Bomb do

  def checkbomb(expected, my_bomb)
    expect(my_bomb.status).to eql(expected[:status])
    expect(my_bomb.activate_code).to eql(expected[:activate])
    expect(my_bomb.deactivate_code).to eql(expected[:deactivate])
  end

  context 'Create a bomb' do
    it 'With the default values' do
      my_bomb = Bomb.new
      expected = { status: 'inactive',
                   activate: '1234',
                   deactivate: '0000' }
      checkbomb(expected, my_bomb)
    end

    it 'With default Activation Code and deactivate code' do
      my_bomb = Bomb.new(activate_code: '9999')
      expected = { status: 'inactive',
                   activate: '9999',
                   deactivate: '0000' }
      checkbomb(expected, my_bomb)
    end

    it 'With default activation code and deactivate code' do
      my_bomb = Bomb.new(deactivate_code: '1234')
      expected = { status: 'inactive',
                   activate: '1234',
                   deactivate: '1234' }
      checkbomb(expected, my_bomb)
    end
  end

  context "Activate a bomb" do
    it 'With default code and the correct code' do
      my_bomb = Bomb.new
      my_bomb.activate('1234')
      expect(my_bomb.status).to eql('active')
    end

    it 'With a custom code and correct code' do
      my_bomb = Bomb.new(activate_code: '9999')
      expected = { status: 'inactive',
                   activate: '9999',
                   deactivate: '0000' }
      checkbomb(expected, my_bomb)
      my_bomb.activate('9999')
      expected = { status: 'active',
                   activate: '9999',
                   deactivate: '0000' }
      checkbomb(expected, my_bomb)
    end

    it 'With the default code and the wrong code' do
      my_bomb = Bomb.new
      my_bomb.activate('9876')
      expect(my_bomb.status).to eql('inactive')
    end

    it 'With a custom code and wrong code' do
      my_bomb = Bomb.new(activate_code: '9999')
      expected = { status: 'inactive',
                   activate: '9999',
                   deactivate: '0000' }
      checkbomb(expected, my_bomb)
      my_bomb.activate('1234')
      expected = { status: 'inactive',
                   activate: '9999',
                   deactivate: '0000' }
      checkbomb(expected, my_bomb)
    end
  end

  context "Deactivate a bomb" do
    it 'Using the default activation code' do
      my_bomb = Bomb.new
      my_bomb.activate('1234')
      expect(my_bomb.status).to eql('active')
      my_bomb.deactivate('0000')
      expect(my_bomb.status).to eql('inactive')
    end

    it 'Using the wrong code, will remaain active' do
      my_bomb = Bomb.new
      my_bomb.activate('1234')
      expect(my_bomb.status).to eql('active')
      my_bomb.deactivate('1234')
      expect(my_bomb.status).to eql('active')
    end

    it 'Using a custom code with the correct code' do
      my_bomb = Bomb.new(deactivate_code: '6789')
      my_bomb.activate('1234')
      expect(my_bomb.status).to eql('active')
      my_bomb.deactivate('6789')
      expect(my_bomb.status).to eql('inactive')
    end

    it 'Using the wrong custom code, will remain active' do
      my_bomb = Bomb.new(deactivate_code: '6789')
      my_bomb.activate('1234')
      expect(my_bomb.status).to eql('active')
      my_bomb.deactivate('678910')
      expect(my_bomb.status).to eql('active')
    end
  end

  context "Bomb Explodes" do
    it 'Since i am an idiot and enter the wrong code three times' do
      my_bomb = Bomb.new
      my_bomb.activate('1234')
      expect(my_bomb.status).to eql('active')
      my_bomb.deactivate('1')
      expect(my_bomb.status).to eql('active')
      my_bomb.deactivate('2')
      expect(my_bomb.status).to eql('active')
      my_bomb.deactivate('3')
      expect(my_bomb.status).to eql('explode')
    end
  end

end
