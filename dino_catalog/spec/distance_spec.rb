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
    values.for_each {|args| 
	expect(edit_distance(args[0],args[1]).to eq(arg[2])
    }
  end
end
