require './matching'

class SimpleToken
  attr_reader :type
  def initialize(type)
    @type = type
  end
end

class FancyToken
  attr_reader :type
  def initialize
    @type = 'Fancy'
  end
end

describe '#matcher' do
  it 'should match the field of an object to a key' \
     ' and pass the object to the proc associated' \
     'with that key' do

    t1 = SimpleToken.new('A')
    t2 = SimpleToken.new('B')
    t3 = SimpleToken.new('C')

    tokens = [t1, t2, t3]

    results = tokens.map do |token|
      OldMatch(lambda { |val| token.type == val }, 'A' => 0xDEADBEEF,
                                                   'B' => 0X55555555,
                                                   'C' => 0x0000000F)
    end

    expect(results[0]).to eq(0xDEADBEEF)
    expect(results[1]).to eq(0x55555555)
    expect(results[2]).to eq(0x0000000F)

    strings = %w(A B C)
    results = strings.map do |val|
      OldMatch(val, 'A' => lambda { SimpleToken.new('A') },
                    'B' => lambda { SimpleToken.new('B') },
                    'C' => lambda { SimpleToken.new('C') })
    end

    expect(results[0].type).to eq('A')
    expect(results[1].type).to eq('B')
    expect(results[2].type).to eq('C')

    tokens = [SimpleToken.new(''), FancyToken.new, SimpleToken.new('')]

    result = tokens.map do |token|
      OldMatch(token.method(:is_a?), SimpleToken => -1,
                                     FancyToken => 3)
    end

    expect(result[0]).to eq(-1)
    expect(result[1]).to eq(3)
    expect(result[2]).to eq(-1)
  end
end

describe '#newMatcher' do
  it 'Should match objects based on ' \
   'equality, instance, and pattern' do

    result = Match('test', 'test' => 'hello')
    expect(result).to eq('hello')

    result = Match('hello', Fixnum => 0,
                            String => 'yay!',
                            NilClass => 'no')
    expect(result).to eq('yay!')

    result = Match('12038', /\d+/ => Integer('12038'),
                            /hello/ => 'Oh no!')
    expect(result).to eq(12_038)
  end
end
