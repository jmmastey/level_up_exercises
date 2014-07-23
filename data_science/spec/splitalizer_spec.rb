require './lib/splitalizer'

describe Splitalizer do

	context 'when B is significantly better' do

		data = SplitalizerDataLoader.parse("./source_data.json")
		splital = Splitalizer.new(data)

		it { expect(splital.winning_group).to eq("B") }
		it { expect(splital.chi).to be > 3.841  }
		it { expect(splital.significant?).to be_truthy  }
		it { expect(splital.b_conv_percent).to be > splital.a_conv_percent }

	end


	context 'when A is significantly better' do

		data = SplitalizerDataLoader.parse("./spec/data/test_a_wins.json")
		splital = Splitalizer.new(data)

		it { expect(splital.winning_group).to eq("A") }
		it { expect(splital.chi).to be > 3.841  }
		it { expect(splital.significant?).to be_truthy  }
		it { expect(splital.a_conv_percent).to be > splital.b_conv_percent }

	end


	context 'when there is no significant difference' do

		data = SplitalizerDataLoader.parse("./spec/data/test_not_significant.json")
		splital = Splitalizer.new(data)

		it { expect(splital.chi).to be < 3.841  }
		it { expect(splital.significant?).to be_falsey  }

	end


end
