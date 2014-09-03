require "./matching"

class SimpleToken
  attr_reader :type
  def initialize(type)
    @type = type
  end
end

describe "#matcher" do
  it "should match the field of an object to a key" +
     " and pass the object to the proc associated" +
     "with that key" do

    t1 = SimpleToken.new("A")
    t2 = SimpleToken.new("B")
    t3 = SimpleToken.new("C") 
   
    tokens = [t1,t2,t3]
  
    results = tokens.map do |token| 
      Match(token,'type', { 
	'A' => lambda {|tok| 0xDEADBEEF },
        'B' => lambda {|tok| 0X55555555 },
        'C' => lambda {|tok| 0x0000000F }
      })
    end

    expect(results[0]).to eq(0xDEADBEEF)
    expect(results[1]).to eq(0x55555555)
    expect(results[2]).to eq(0x0000000F)
  end
end

