require 'data_science/data_point'

module DataScience
  describe DataPoint do
    json_data = { "date" => "2014-03-20", "cohort" => "B", "result" => 0 }
    let(:data_point) { DataPoint.new(json_data) }

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
