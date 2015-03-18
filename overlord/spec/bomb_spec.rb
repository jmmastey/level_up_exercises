require_relative '../models/bomb'

describe Bomb do

  context 'Create a bomb' do
    it 'Create a bomb with the default values' do
      my_bomb = Bomb.new
      checkbomb(%w(inactive 1234 0000), my_bomb)
    end

    it 'Create a bomb with a custom Activation Code and default deactivate code' do
      my_bomb = Bomb.new(activate_code: '9999')
      checkbomb(%w(inactive 9999 0000), my_bomb)
    end

    it 'Create a bomb with default activation code and custom deactivate code' do
      my_bomb = Bomb.new(deactivate_code: '1234')
      checkbomb(%w(inactive 1234 1234), my_bomb)
    end
  end

  context "Activate a bomb" do
    it 'Activate a bomb with default code and the correct code' do
      my_bomb = Bomb.new
      my_bomb.activate('1234')
      expect(my_bomb.status).to eql('active')
    end

    it 'Activate a bomb with a custom code and correct code' do
      my_bomb = Bomb.new(activate_code: '9999')
      checkbomb(%w(inactive 9999 0000), my_bomb)
      my_bomb.activate('9999')
      checkbomb(%w(active 9999 0000), my_bomb)
    end

    it 'Attempt Activate a bomb with the default code and the wrong code' do
      my_bomb = Bomb.new
      my_bomb.activate('9876')
      expect(my_bomb.status).to eql('inactive')
    end

    it 'Attmept to Activate a bomb with a custom code and wrong code' do
      my_bomb = Bomb.new(activate_code: '9999')
      checkbomb(%w(inactive 9999 0000), my_bomb)
      my_bomb.activate('1234')
      checkbomb(%w(inactive 9999 0000), my_bomb)
    end
  end

  context "Deactivate a bomb" do
    it 'Deactivate a bomb using the default activation code with the correct code' do
      my_bomb = Bomb.new
      my_bomb.activate('1234')
      expect(my_bomb.status).to eql('active')
      my_bomb.deactivate('0000')
      expect(my_bomb.status).to eql('inactive')
    end

    it 'Attempt to Deactivate a bomb with the wrong code' do
      my_bomb = Bomb.new
      my_bomb.activate('1234')
      expect(my_bomb.status).to eql('active')
      my_bomb.deactivate('1234')
      expect(my_bomb.status).to eql('active')
    end

    it 'Deactivate a bomb using a custom code with the correct code' do
      my_bomb = Bomb.new(deactivate_code: '6789')
      my_bomb.activate('1234')
      expect(my_bomb.status).to eql('active')
      my_bomb.deactivate('6789')
      expect(my_bomb.status).to eql('inactive')
    end

    it 'Attempt to Deactivate a bomb using a custom code with the incorrect code' do
      my_bomb = Bomb.new(deactivate_code: '6789')
      my_bomb.activate('1234')
      expect(my_bomb.status).to eql('active')
      my_bomb.deactivate('678910')
      expect(my_bomb.status).to eql('active')
    end
  end

  context "Bomb Explodes" do
    it 'i am an idiot and enter the wrong code three times' do
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

  def checkbomb(status, my_bomb)
    expect(my_bomb.status).to eql(status[0])
    expect(my_bomb.activate_code).to eql(status[1])
    expect(my_bomb.deactivate_code).to eql(status[2])
  end

end
