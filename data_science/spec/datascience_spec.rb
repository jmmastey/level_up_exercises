require_relative '../datascience'
require 'date'

describe DataScience do 
  let(:experiment) { described_class.new }
  let(:default_json_file) { 'data_export_2014_06_20_15_59_02.json' }
  let(:mock_data)  do
    Array.new(40) do |i|
      { 
        'date'   => Date.today.to_s,
        'cohort' => i.even? ? 'A' : 'B',
        'result' => i % 3 == 0 ? 0 : 1
      }
    end
  end
  let(:mock_cohort_names) {["A", "B"]}
  let(:mock_counts) do
    {"B_0"=>1000, "B_total"=>1500, "B_1"=>500, "A_0"=>1000, "A_total"=>1500, "A_1"=>500}
  end
  
  describe '#initalize' do
    context 'without any arguments' do
      it 'does not raise an error' do
        expect { experiment }.to_not raise_error
      end

      it 'uses the default JSON file' do
        expect(experiment.json_file).to eq default_json_file
      end
    end

    context 'with a JSON file specified' do
      before { experiment = described_class.new('dat.json') }

      it '' do
      end
    end
  end

  describe '#data' do
    let(:json_data) { { name: "test" , description: "test"}.to_json }

    before do
      expect(experiment).to receive(:json_file).and_return('foo.json')
      allow(File).to receive(:read).with('foo.json').and_return(json_data)
    end

    context 'with a file specified' do
      before { expect(File).to receive(:exist?).and_return(true) }

      it 'loads the file' do
        expect(experiment.data).to eq("name" => "test", "description" => "test")
      end
    end

    context 'with a file that does not exist' do
      before { expect(File).to receive(:exist?).and_return(false) }

      it 'raises an ArgumentError' do
        expect{ experiment.data }.to raise_error ArgumentError
      end
    end
  end

  describe '#chi_sq' do
    it "returns an Array with size 2" do
      expect(experiment.chi_sq).to be_an Array
      expect(experiment.chi_sq.size).to eq(2)
    end

    it 'returns a boolean as the first value' do
      expect(experiment.chi_sq[0]).to match boolean()
    end

    it 'returns a number as the second value' do
      expect(experiment.chi_sq[1]).to be_a Float
    end

    context 'with statistically significantly different data' do
      let(:mock_values) do
        { agroup: { :"1" => 15, :"0" => 285 },
          bgroup: { :"1" => 5,  :"0" => 295 } 
        }
      end

      before do
        expect(experiment).to receive(:values).and_return(mock_values)
      end
      
      it 'returns an expected chi sq value' do
        expect(experiment.chi_sq).to eq [true, 0.023]
      end
    end

    context 'with statistically insignificantly different data' do
      let(:mock_values) do
        { agroup: { :"1" => 6, :"0" => 294 },
          bgroup: { :"1" => 5, :"0" => 295 } 
        }
      end

      before do
        expect(experiment).to receive(:values).and_return(mock_values)
      end
      
      it 'returns an expected chi sq value' do
        expect(experiment.chi_sq).to eq [false, 0.761]
      end
    end

    context 'with identically distributed data' do

      before do
        expect(experiment).to receive(:data).and_return(mock_data)
      end
      
      it 'returns max chi sq value' do
        expect(experiment.chi_sq).to eq [false, 1.0]
      end
    end
  end

  describe '#conversion_rate' do
    context 'with counts given for each cohort' do
      before do
        allow(experiment).to receive(:cohort_names).and_return(mock_cohort_names)
        allow(experiment).to receive(:counts).and_return(mock_counts)
      end
      
      it 'returns a hash of expected conversion rates' do
        expect(experiment.conversion_rate).to eq("A"=>0.333, "B"=>0.333)
      end
    end
  end

  describe '#conversion_rate_error' do
    context 'with counts and conversion rate' do
      before do
        allow(experiment).to receive(:cohort_names).and_return(mock_cohort_names)
        allow(experiment).to receive(:counts).and_return(mock_counts)
      end
      
      it 'returns a hash of expected conversion rate errors' do
        expect(experiment.conversion_rate_error).to eq("A"=>0.017, "B"=>0.017)
      end
    end
  end

  describe '#counts' do
    let(:mock_data) do
      Array.new(1000) { { 'cohort' => 'B', 'result' => 0 } } +
      Array.new(500)  { { 'cohort' => 'B', 'result' => 1 } } +
      Array.new(1000) { { 'cohort' => 'A', 'result' => 0 } } +
      Array.new(500)  { { 'cohort' => 'A', 'result' => 1 } }
    end

    before { expect(experiment).to receive(:data).and_return(mock_data) }

    it 'returns a summary of the data' do
      expect(experiment.counts).to eq({"B_0"=>1000, "B_total"=>1500, "B_1"=>500, "A_0"=>1000, "A_total"=>1500, "A_1"=>500})
    end
  end
end