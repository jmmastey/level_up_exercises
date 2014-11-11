require 'data_science/sample'
require_relative '../factories'

module DataScience
  describe Sample do
    before do
      @sample = Sample.new
      @sample_data = [{"date"=>"2014-03-20", "cohort"=>"B", "result"=>0}, {"date"=>"2014-03-20", "cohort"=>"B", "result"=>0}]
    end

    it 'is instantiated with an empty array of data points' do
      expect(@sample.data_points).to eq([])
    end

    it 'adds a data point to itself' do
      @sample.add_data_to_sample(@sample_data)
      expect(@sample.data_points.size).to eq(2)
    end

    context 'calculate sample statistics' do
      before do
        @control_group_non_conversions = build_list(:control_group_no_conversion, 744)
        @control_group_conversions = build_list(:control_group_conversion, 320)
        @test_group_non_conversions = build_list(:test_group_no_conversion, 793)
        @test_group_conversions = build_list(:test_group_conversion, 250)

        @control_group_non_conversions.each { |data_point| @sample.data_points << data_point }
        @control_group_conversions.each { |data_point| @sample.data_points << data_point }
        @test_group_non_conversions.each { |data_point| @sample.data_points << data_point }
        @test_group_conversions.each { |data_point| @sample.data_points << data_point }
      end

      it 'calculates the total sample size' do
        expect(@sample.sample_size).to eq(2107)
      end

      it 'calculates the number of conversions for the Control group' do
        expect(@sample.conversions("A")).to eq(320)
      end

      it 'calculates the number of conversions for the Test group' do
        expect(@sample.conversions("B")).to eq(250)
      end

      it 'calculates the number of non-conversions for the Control group' do
        expect(@sample.non_conversions("A")).to eq(744)
      end

      it 'calculates the number of non-conversions for the Test group' do
        expect(@sample.non_conversions("B")).to eq(793)
      end

      it 'calculates the cohort size for the Control group' do
        expect(@sample.cohort_size("A")).to eq(1064)
      end

      it 'calculates the cohort size for the Test group' do
        expect(@sample.cohort_size("B")).to eq(1043)
      end

      it 'calculates the conversion rate for the Control group' do
        expect(@sample.conversion_rate("A")).to be_within(0.0001).of(0.3008)
      end

      it 'calculates the conversion rate for the Test group' do
        expect(@sample.conversion_rate("B")).to be_within(0.0001).of(0.2397)
      end

      it 'calculates the standard error for the Control group' do
        expect(@sample.standard_error("A")).to be_within(0.00001).of(0.01406)
      end

      it 'calculates the standard error for the Test group' do
        expect(@sample.standard_error("B")).to be_within(0.0001).of(0.0132)
      end

      it 'calculates the error bars conversion with a 95% confidence for the Control group' do
        expect(@sample.error_bars("A")).to be_within(0.00001).of(0.02756)
      end

      it 'calculates the error bars conversion with a 95% confidence for the Test group' do
        expect(@sample.error_bars("B")).to be_within(0.00001).of(0.02590)
      end

      it 'calculates the confidence level of the sample for cohorts A and B' do
        expect(@sample.confidence_level("A", "B")).to be_within(0.01).of(0.99)
      end
    end
  end
end
