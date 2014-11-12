require 'data_science/data_point'

module DataScience
  describe DataPoint do
    let(:data_point) { DataPoint.new({ "date"=>"2014-03-20", "cohort"=>"B", "result"=>0 }) }

    it 'has a date' do
      expect(data_point.date).to eq("2014-03-20")
    end

    it 'has a cohort' do
      expect(data_point.cohort).to eq("B")
    end

    it 'has a result' do
      expect(data_point.result).to eq(0)
    end
  end
end
