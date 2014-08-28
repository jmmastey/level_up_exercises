require './distance'

describe "#editDistance" do
  it "returns the minimum number of edits that " +
     "need to occur for one string to equal the " +
     "value of another string." do
    values = [ 
		['fire','water',4],
		['good', 'goodbye',3],
		['kitten', 'sitting', 3],
		['dog','rug',2],
		['abcdefg','accdeff',2]
	]
    values.each {|args| 
	expect(Distance::edit_distance(args[0],args[1])).to eq(args[2])
    }
  end
end

describe "#similarity" do
  it "returns a normalized value of the edit" +
     "by dividing the distance by length" do
    values = [ 
		['fire','water',4],
		['good', 'goodbye',3],
		['kitten', 'sitting', 3],
		['dog','rug',2],
		['abcdefg','accdeff',2]
	]
    values.each {|args| 
	expect(Distance::similarity(args[0],args[1])).to eq(args[2].to_f / args[0].size)
    }
  end
end
